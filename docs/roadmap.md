

### Vscode Workspaces

This feature allows all ki commands to be fitlered to an active vscode workspace. 
kiwi wsfile - workspace incept a workspace file.
kiwix  - removes filtering for active ws file.
This is particularly useful for monorepos, where the directories to work on can be extensive.

Try keeping your workspaces in the kish workspaces folder. Can be very useful for 
complex features across many diretories / files. Try naming by feature &/ issue number.

### Structure
Ki Sh is organised into two repos ki-core and kish. This is so you can save your aliases in your own
repo, and also have semantic versioning separation from the core code, and update the core as you need.
I took this approach over something like Oh My Zsh to give the user more control, and not have 
thousands of shortcut codes you may never need or want. Basicly more signal less noise. It also
makes it vialbe to share youe repo across your organisation, and may even be useful for advanced scenarios like
multi-repo deployments.

