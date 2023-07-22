PS1="$> "
# Welcome to Ki sh.
# to get started make your own repo from kish template: https://github.com/ki-sh/kish
# and clone it to your device:
git clone https://github.com/ki-sh/kish.git
cd kish
npm i
npm run kiu
# start a new terminal
ki
cd .. # come out of kish


# to start, getthe demonstration poly repo:
git clone https://github.com/ki-sh/poly-ex.git
# here we go - no cd poly_ex, cd .. after. good riddance cd!
nr poly-ex clone:all
# you now have multiple repos cloned to apps and packages.
# take a look:
l apps/* packages/*
# lets checkout a new branch on them all:
gcob setup  apps/* packages/*
# and lets check the branches:
gb apps/* packages/*
# want each of them to have npm package:
 n init -y apps/* packages/*
# say you wanted to run all the tests in all the repos in one go:
nr apps/* packages/* test
# lets do some source control
# add all the new package.json's:
ga apps/* packages/*
# check added:
gs apps/* packages/*
# commit:
gc 'npm initialised' apps/* packages/*
# you wont have access to push, but if you did,can simply:
gpu apps/* packages/*
# you can ki enable any command without having to make an alias:
ki cat apps/w*/package.json
# say you'd like to add cat as an alias:
kin
#at options enter: kat, cat, y. 
kiu #update the aliases
# start a new terminal.
ki #see your alias is added to the help.
# ready to use:
kat apps/w*/package.json

# enjoy.
# we hope you find ki super useful - like how did we live without this before useful :)
# We'll ask you to buy us a coffee after youve used it a thousand times.
# thats all we ask - we save you Ten coffes worth of time and effort - get us one!
# or if you love it alread there is a link when you type ki. thx!

# add coffee to ki (help)
# ocal
# omap
# kit
# workspaces

