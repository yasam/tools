

clear_proxy()
{
    X=`env | grep proxy | cut -d '=' -f1`
    for Y in $X; 
    do
	echo "unsetting $Y"
	unset $Y
    done

}


