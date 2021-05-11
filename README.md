This quick readme assumes that Tierpsy Tracker is already installed
on Krypton, in a conda env named `tierpsy`.

To create the project directory tree, on Krypton:
```
cd ~
source activate tierpsy
conda install cookiecutter  # first time only
cookiecutter https://github.com/Tierpsy/RemoteTierpsyKrypton.git
```
Then insert your github credentials, and the project name as prompted.
This will be appended to the word `tierpsy_`, e.g. if `project_name` is `keio`,
the working folder will be made in `~/tierpsy_keio/`

The working folder created will contain the usual `RawVideos`, `MaskedVideos`,
`Results`, and `AuxiliaryFiles` subfolders. In addition to this, two more subfolders
are created: `workspace` and `sumamrizer`. These are rather Krypton specific,
and contain the scripts for running the analysis.

Once the directory tree has been created,
copy the raw videos from the network share to `RawVideos`.
You can do that from any computer that is physically on the LMS network,
with `scp`. E.g. (modify your username):
```
scp -r /Volumes/hermes$/KeioScreen_96WP/RawVideos/20210504 yourusername@krypton.cscdom.csc.mrc.ac.uk:./tierpsy_keio/RawVideos
```
You also need to copy any json file that you want to use, if that is different
than the "standard" Hydra analysis (96WP, with Neural Network, no background subtraction)

From here on, you can follow Eleni's guide on `behavgenom$`.
You'll only have to change the number of videos to analyse,
and the filename of the parameters json file you want to use.

TODO: incorporate Eleni's guide here.
