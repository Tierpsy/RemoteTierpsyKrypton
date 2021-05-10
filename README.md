Assuming tierpsy is already installed in a `tierpsy` conda env in Krypton:
```
cd ~
source activate tierpsy
conda install cookiecutter  # first time only
cookiecutter https://github.com/Tierpsy/RemoteTierpsyKrypton.git
```
Then insert your github credentials, and the project name as prompted.
This will be appended to the word `tierpsy_`, e.g. if `project_name` is `keio`,
the working folder will be made in `~/tierpsy_keio/`

TODO: finish the readme :)
