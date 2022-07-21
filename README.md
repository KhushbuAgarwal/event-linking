Test event linking


## To install phenosage in a new conda envioment
med-phenosageconda create -n mynev python=3.9. 

conda activate myenv. 

conda install pytorch==1.9.0 torchvision==0.10.0 torchaudio==0.9.0 cudatoolkit=10.2 -c pytorch. 

conda install pytorch-geometric -c rusty1s -c conda-forge. 
   

Note: Some versions of pytorch-geometric install with a missing logging.py from main folder.
To fix the error, copy the logging.py file from
https://github.com/pyg-team/pytorch_geometric/blob/master/torch_geometric/logging.py
to the new conda environment site packages. 
example I copied the file here :
~/.conda/pkgs/pytorch-geometric-2.0.3-py39_torch_1.9.0_cu102/lib/python3.9/site-packages/torch_geometric/logging.py. 


## To run phenosage
conda activate myenv. 

python gcn.py.

