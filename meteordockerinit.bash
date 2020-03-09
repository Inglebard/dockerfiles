#/bin/bash
#This command will download latest version of meteor and copy the content from ~/.meteor to PATH specify.
#Not really pretty, but can mount empty directory directly into ~/.meteor because meteor need to delete .meteor to recreate .meteor (not possible because of mount).

display_help()
{

	printf -- "Usage 'bash meteorinit.bash \e[4mPATH\e[0m'\n\n"

	printf -- "This command will download latest version of meteor and copy the content from ~/.meteor to \e[4mPATH\e[0m specify."
	printf -- "\n\n"

}


if [ "$#" -ne 1 ]; then
  printf -- "Illegal number of parameters.\n\n"
	display_help
	exit 1
fi

if [ ! -d "$1" ]; then
  printf -- "The path is not valid.\n\n"
	display_help
	exit 1
fi

if [ "$(ls -A $1)" ]; then
  	printf -- "Directory is not empty.\n\n"
	 	exit 1
fi


meteor update
if [ $? -eq 0 ]; then
    printf -- "meteor update ...OK\n"
else
	printf -- "meteor update ...FAILED\n"
	exit 1
fi

cp -r ~/.meteor/* "$1"
if [ $? -eq 0 ]; then
    printf -- "meteor copy ...OK\n"
else
	printf -- "meteor copy ...FAILED\n"
	exit 1
fi

exit 0
