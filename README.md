# Config files

This is a repo to hold my configuration in a single place and save a history of how they evolve.

## Process

I created a directory to hold the configuration files where I created a git repo. The files live here but use a **symlink** to their respective location in order to work for their program. I will eventually move all my configuration files here and create scripts to instanciate them easily should anything happen to them.

### Individual files

1. Relocate to repo directory
2. Use **ln** command to create a symlink `ln -s <FILEPATH> <DESTINATION>`

**Note:** The filepath _has to be absolute in order for the ln command to work_.

Changes done in either file will be reflected on both.
