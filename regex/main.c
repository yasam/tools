#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <regex.h>
#include <pty.h>

int main()
{
    char *pcRegex = "All host RR's have been announced/verified : (.*)";
    char *apcArgs[5];
    regex_t tRegexData;
    regmatch_t tMatch[2];
    pid_t iPid;
    int iMaster = -1;
    int iCount = 0;
    char buf[1024];
    int l = 0;
    int iRetVal;
    ssize_t tSize = 2;
    char *pcPtr;
    char tmp[1024];

    regcomp(&(tRegexData), pcRegex, REG_EXTENDED);

    iPid = forkpty(&iMaster,0,0,0);
    if(iPid == 0){
	apcArgs[iCount++] = "/bin/echo";
	apcArgs[iCount++] = "/bin/echo";
	//apcArgs[iCount++] = "Server startup complete. SERVER RUNNING";
	apcArgs[iCount++] = "All host RR's have been announced/verified : SERVER RUNNING";
	apcArgs[iCount] = NULL;

	if(execvp(apcArgs[0], apcArgs+1)<0)
	{
		perror("execvp failed:");
		exit(77);
	}
    }
    else if(iPid > 0){
	while(1){
	    l = read(iMaster, buf, 1024);
	    if(l <= 0)
		continue;

	    buf[l] = 0;
	    printf("buf:%s\n", buf);
	    iRetVal = regexec(&tRegexData, buf, tSize, tMatch, 0);
	    if(iRetVal == 0)
	    {
		if ((tMatch[1].rm_so != -1 && tMatch[1].rm_eo > 0) ||
		    (tMatch[1].rm_so == -1 && tMatch[1].rm_eo == -1))
		{

		    pcPtr = buf + tMatch[1].rm_so;
		    iCount = tMatch[1].rm_eo - tMatch[1].rm_so; // -1?
		    strncpy(tmp, pcPtr, iCount);
		    tmp[iCount] = 0;
		    printf("matched:%s\n", tmp);
		}
		else{
		    printf("not found");
		}
	    }
	    else{
		printf("retval:%d\n", iRetVal);
	    }
	}
    }
}
