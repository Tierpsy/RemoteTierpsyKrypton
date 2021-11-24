# Tierpsy on Krypton

- [The system](#the-system)
- [Krypton basics](#krypton-basics)
  - [Login](#login)
    - [If you are working remotely](#if-you-are-working-remotely)
    - [From within the LMS network](#from-within-the-lms-network)
  - [Moving data to and from Krypton](#moving-data-to-and-from-krypton)
    - [Copying files between your local machine and Krypton](#copying-files-between-your-local-machine-and-krypton)
    - [Copying files between the group share and Krypton](#copying-files-between-the-group-share-and-krypton)
    - [Mounting the group share in the Krypton home](#mounting-the-group-share-in-the-krypton-home)
- [Using Tierpsy on Krypton](#using-tierpsy-on-krypton)
  - [Installing Tierpsy on Krypton (first time only)](#installing-tierpsy-on-krypton-first-time-only)
  - [Initialising a project folder](#initialising-a-project-folder)
  - [Processing videos](#processing-videos)
    - [Explanation](#explanation)
    - [How-to](#how-to)
    - [Check up on your analysis](#check-up-on-your-analysis)
    - [Check that all files have been analysed](#check-that-all-files-have-been-analysed)
  - [Running the summarizer](#running-the-summarizer)
  - [Moving the results away from Krypton](#moving-the-results-away-from-krypton)

## The system

Krypton is a cluster made of 8 nodes in total. Each node has 28 cores (cpus). This emans that we have 224 cores available in total (for comparison, the MacPros have 24 cores each). This cluster is shared with all the groups in the LMS. However at the moment very few people are using it, so most of the times all the cores are available.

You can find some more information on the system [here](http://intranet.lms.mrc.ac.uk/index.php/help-and-resources/computing-help-desk/frequently-asked-questions/lms-hpc/). You should read it if you plan to use Krypton.

## Krypton basics

### Login

You can interact with Krypton with a `ssh` shell.

#### If you are working remotely
You cannot connect to Krypton directly from outside the LMS network, even if you're on the VPN.\
You'll need to contact the LMS IT and ask them to give you access to the Terminal Server. They will configure that for you, and help you set up PuTTY so you can connect to Krypton, following the instructions below, via the Terminal Server.

#### From within the LMS network
Open a terminal in your local machine and login to krypton, using the command:
``` bash
ssh krypton.cscdom.csc.mrc.ac.uk
```

If you login from a machine other that your own computer (for example from one of the MacPros), use:
``` bash
ssh $user@krypton.cscdom.csc.mrc.ac.uk
```
where `$user` is your username. You will be asked to give your password.

You are now in your personal home directory in Krypton `/mnt/storage/home/$user$/`

### Moving data to and from Krypton

To analyse data on Krypton, first you'll need to copy your data to your home directory on it. There are a few commands and method that you can use. Below we'll see some examples for the most common cases. \

#### Copying files between your local machine and Krypton

Open a terminal in your local machine. To copy a file `pathlocal/file.ext` from your local machine to a folder `pathkrypton` in your home directory in Krypton use one of the following commands:
``` bash
scp pathlocal/file.ext $user@krypton.cscdom.csc.mrc.ac.uk:pathkrypton/
rsync pathlocal/file.ext $user@krypton.cscdom.csc.mrc.ac.uk:pathkrypton/
```

There are many options you can use with any of these two commands (for example you can recursively copy entire folders), and you can read about them by typing in your terminal:
``` bash
man scp
man rsync
```

You can copy things from krypton to your local machine in the same way:
``` bash
scp $user@krypton.cscdom.csc.mrc.ac.uk:pathkrypton/file.ext pathlocal/
rsync $user@krypton.cscdom.csc.mrc.ac.uk:pathkrypton/file.ext pathlocal/
```

#### Copying files between the group share and Krypton

First, make sure you have mounted the group share to your local machine (Finder -> Go -> Connect to Server -> connect to the group share).

Then run one of the following commands, using the appropriate paths:
``` bash
scp /Volumes/behavgenom$/path/file.ext $user@krypton.cscdom.csc.mrc.ac.uk:pathkrypton/
rsync /Volumes/behavgenom$/path/file.ext $user@krypton.cscdom.csc.mrc.ac.uk:pathkrypton/
```

#### Mounting the group share in the Krypton home

You can contact IT and ask them to help you mount the group shares directly in your Krypton home. \
This is not meant to be a way to copy large amount of data to and from the group share, and it comes with some risks about the integrity of behavgenom.\
It is therefore important that IT is aware this is happening, and that they give you all the relevant advice.
> Note that it is not possible to process data directly from the group share without copying it in the Krypton home first.


## Using Tierpsy on Krypton

This is a summary of the steps one needs to take to run Tierpsy in Krypton.\
Here we assume that you are logged into Krypton


### Installing Tierpsy on Krypton (first time only)

You should install Tierpsy Tracker from source in a virtual environment.
The process is very similar to the one explained in [Tierpsy's github repo](https://github.com/Tierpsy/tierpsy-tracker/), but with the instructions below you can use an environment `.yml` file that has been tested on Krypton before, and, crucially, installs `cookiecutter` for you.

On Krypton:
``` bash
cd ~
module load Anaconda 3  # this makes conda available
git clone https://github.com/Tierpsy/tierpsy-tracker
```

On your local machine, making sure `behavgenom$` is mounted:
``` bash
scp /Volumes/behavgenom$/Documentation/Krypton_Tierpsy/tierpsy_krypton.yml $user@krypton.cscdom.csc.mrc.ac.uk:tierpsy-tracker/
```

Finally back on Krypton:
``` bash
cd ~/tierpsy-tracker
conda env create -f=tierpsy_krypton.yml
source activate tierpsy
pip install -e .
```

Tierpsy is now installed.

Finally, you should create a temporary folder in your Krypton home that Tierpsy can use for processing:
``` bash
mkdir ~/Tmp
```


### Initialising a project folder
Here we assume you're logged into Krypton, and that Tierpsy Tracker and `cookiecutter` are already installed on Krypton, in a conda env named `tierpsy`.

To create the project directory tree, on Krypton:
```
cd ~
module load Anaconda3  # whenever you log in
source activate tierpsy  # unless the prompt already shows (tierpsy)
cookiecutter https://github.com/Tierpsy/RemoteTierpsyKrypton.git
```
Then insert your github credentials, and the project name as prompted.
This will be appended to the word `tierpsy_`, e.g. if `project_name` is `myproject`,
the working folder will be made in `~/tierpsy_myproject/`.
The project folder will also be automatically inserted in all the right places in the various scripts that are needed to run the analysis on Krypton (see the next section for more details).

The working folder created will contain 6 subfolders:
- `RawVideos`: standard Tierpsy folder that will contain the microscope videos
- `MaskedVideos`: standard Tierpsy folder where the masked videos will be put
- `Results`: standard Tierpsy folder where the skeletons and features files will go
- `AuxiliaryFiles`: standard folder for metadata, pre-populated with a standard json file with Tierpsy parameters for Hydra videos
- `workspace`: Krypton specific folder, contains scripts for batch processing
- `summarizer`: Krypton specific folder, contains scripts for collecting the features' summaries

Once the directory tree has been created,
copy the raw videos from the network share to `RawVideos`.
You can do that from any computer that is physically on the LMS network,
with `scp`. E.g. (modify your username, and the project folder):
``` bash
scp -r /Volumes/behavgenom$/myproject/RawVideos/20210504 $user@krypton.cscdom.csc.mrc.ac.uk:tierpsy_myproject/RawVideos/
```
You also need to copy any json file that you want to use to the `AuxiliaryFiles` folder, if that is different from the "standard" Hydra analysis (96WP, with Neural Network, no background subtraction).

### Processing videos

#### Explanation
When we use the Batch Process Files option in Tierpsy on a desktop or laptop, Tierpsy will automatically find all the files to analyse, and handle how individual files are assigned to individual cores to be processed.

In Krypton we need to do something similar: we create what is called a Job Array, i.e. a collection of tasks each of which will be executed by a single core. Each task is the processing of a single file. We then submit the Job Array to a Queue, and Krypton will start executing the individual tasks as cores become available.

However, since we do not have a graphical user interface, we need to do this with a few scripts.

#### How-to

The first script to run is called `get_files2process.sh`. It will first scan the `RawVideos` folder looking for non-analysed videos, and save a very long output to the file `tierpsy_output.txt`. This file contains a list of individual commands that can be used to analyse the individual videos, and some summary information at the end. The script then parses the `tierpsy_output.txt` and saves the "cleaned up" list of individual commands into a different text file, `files2process.txt`.

Assuming our project folder is `tierpsy_myproject`:
``` bash
cd ~/tierpsy_myproject/workspace
bash get_files2process.sh
```
This can take a few minutes.

>You should not have to modify `get_files2process.sh`, _**unless you either**_:
>- want to analyse `MaskedVideos` instead of `RawVideos`. In this case you need to:
>  - erase the parameter `--video_dir_root` and its value
>  - make Tierpsy look for `hdf5` files: `--pattern_include "*.hdf5"`
>  - add the parameter `--force_start_point 'TRAJ_CREATE' `
>- want to use a different `json` file, in which case you'll need to change the path in the line that starts with `--json-file`
>- prefer not to use a temporary directory, in which case pass add this parameter: `--tmp_dir_root ''`
>
>Remember you can alway access a full list of options for the command `tierpsy_process` by typing:
>``` bash
>tierpsy_process --help
>```

![get_files2process_default](https://user-images.githubusercontent.com/33106690/143306393-65864925-c28b-46d5-897d-e19863ad41db.png)|![get_files2process_annotated](https://user-images.githubusercontent.com/33106690/143306386-58271e3f-78f7-42e4-b8f6-371ba85c1996.png)
:---:|:---:

Now we need to know how many files need to be processed. You can read this with
``` bash
tail tierpsy_output.txt
```
![cat_tierpsy_output](https://user-images.githubusercontent.com/33106690/143305690-bf25e238-352b-446e-93cb-2283ed55d4fa.png)

This value is the number of tasks Krypton needs to execute for us, and needs to be plugged into the `process_all.pbs` script. You can edit it with, e.g., `nano`:
``` bash
nano process_all.pbs
```
Then see the following screenshot for how to modify. `Ctrl + X -> Y -> Enter` to save the changes and exit.

![process_all](https://user-images.githubusercontent.com/33106690/143306893-eb7e20dd-bbc8-47ae-b1f7-02cc3024fe1c.png)

At this point, we only need to send the Job Array to the cluster to run:
``` bash
qsub process_all.pbs
```
![qsub](https://user-images.githubusercontent.com/33106690/143305588-5f7eae56-573c-45c2-848f-58ee0de6484c.png)
Your analysis is now running.

#### Check up on your analysis
You can check the state of job array by running:
- `qstat`\
  This checks the parent job\
  ![qstat](https://user-images.githubusercontent.com/33106690/143305551-fc293cbd-96fc-47b1-a173-0668ad531dfb.png)
- `qstat -t`\
  checks the individual jobs of the array. The number in the square bracked is the ID of the individual job inside the array. It ranges from 1 to the total number of files you are processing\
  ![qstat_t](https://user-images.githubusercontent.com/33106690/143305509-f74a5957-62ae-47ea-9511-531090bcbf91.png)
- `qstat -tr`\
  lists only the running jobs\
  ![qstat_tr](https://user-images.githubusercontent.com/33106690/143305460-bd9d0b1f-94b7-4110-8c7b-8d359f1ce0e8.png)

The progress of an individual job with array ID `$N` (i.e. the output that would be printed in the analysis window of the Tierpsy GUI) is printed in a text file `output.$N` in the folder `pbs_output`. Therefore to monitor the progress of individual tasks you can read the corresponding file, using for example
- `cat pbs_output/output.$N` or in alternative
- `tail pbs_output/output.$N`\

from the `workspace` subfolder in the project folder.

#### Check that all files have been analysed
When all jobs in the array have finished, it's a good idea to check that all videos have been processed properly. The easiest way is to re-run `bash get_files2process.sh` and checking that Tierpsy returns
```
***************************************
0   Total files to be processed.
***************************************
```

If the number is not 0, you can look inside the newly-modified `tierpsy_output.txt` which files still need to be analysed, and can try to investigate why their analysis failed by looking at the `output.$n` files.

Krypton is known to sometimes fail in the `COMPRESS` stage, with an error that I suspect is linked to a temporary drop in the connection between the cluster and the storage partition.
Simply restarting the analysis (after updating the number of tasks in `process_all.pbs`) usually works.


### Running the summarizer

You can use Krypton to collect the feature summaries as well. By default the summarizer on Krypton creates summaries for each day of experiments, to speed up the calculations. You'll need to join these day-summaries using the appropriate functions from [tierpsy-tools-python](https://github.com/Tierpsy/tierpsy-tools-python). You'll also have to change the paths so that they work on your local machine for downstream analysis.

Running the summarizer is very similar to processing the video files.\
Briefly:
- `cd ~/tierpsy_myproject/summarizer`: places you into the right directory
- (Optional) Modify `calculate_feat_summaries.py` if you want to change the summariser parameters e.g. to add time windows and filters.
- `bash get_cmd2process.sh` to create the list of commands for the queue. It will be one command per day of imaging.
- In `process_all.pbs`, modify the line that starts with `PBS -J` so that the last number is the number of imaging days you're processing
- `qsub process_all.pbs`

### Moving the results away from Krypton
When all files have been processed you should copy the `MaskedVideos` and/or the `Results` back to your local machine or the group share, with the commands seen in [this section](#moving-data-to-and-from-krypton).

Make sure that both the input files you analysed AND the results are safely stored in your local machine or the group share and then delete them from Krypton.


