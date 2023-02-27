# Toddler Bash Script

Add executable permissions with `+x` and run it `./toddler.sh`.

It should generate a `./todo` folder with `TODO.md` containing an unorganized list
of your TODO comments and the locations.

Current support of the comments: 
- `//`
- `/* */`
- `#`

I plan to add a lot more comments and make it suitable for C/C++/Java etc. development and also add in some other features.

If you wish to change the directory of the script, you will need to change the `directory` and `output_file` in the script itself for now.
I will add ability to pass the arguments to the script later on with automations.

This tool is meant for people that tend to keep their TODOs scattered accross the
codebase, me being one of them, when working on "fun projects". This way, you can get all your TODOs into one place (Theres a low chance that one might actually remember all his TODO comments). This is aimed towards solo projects (You're prolly using jira/gh issues). I wanted to keep all my todos in the codebase but in one place.

Next things i hope i'll acomplish are changing this into a deb/npm package and creating some automation recepies with nodemon 

Wish me luck!
