module load Anaconda3
source activate tierpsy

tierpsy_process --video_dir_root "$HOME/tierpsy_{{cookiecutter.project_name}}/RawVideos" \
 --mask_dir_root "$HOME/tierpsy_{{cookiecutter.project_name}}/MaskedVideos" \
 --results_dir_root "$HOME/tierpsy_{{cookiecutter.project_name}}/Results" \
 --only_summary \
 --json_file "$HOME/tierpsy_{{cookiecutter.project_name}}/AuxiliaryFiles/loopbio_rig_96WP_splitFOV_NN_20200526.json" \
 --pattern_include "*.yaml" \
 --is_debug --copy_unfinished | tee "$HOME/tierpsy_{{cookiecutter.project_name}}/tierpsy_output.txt"

python $HOME/tierpsy_{{cookiecutter.project_name}}/workspace/filter_files2process.py
