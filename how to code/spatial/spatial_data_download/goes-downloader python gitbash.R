


# Download python
# https://github.com/uba/goes-downloader
# open git bash
#check if python is installed
python --version
#check if pip3 is installed
pip --version

# set up to download
git clone https://github.com/uba/goes-downloader.git
pip3 install -r requirements.txt

# Download GOES-18 GLM data, between 2023-07-01 (july 1, 2023) and 2023-10-01 (oct 1, 2023), All-hours. (not available for goes-18, only goes-16, goes-17)
goes-downloader.py -satellite GOES-18
-products ABI-L2-FDCF
-start 20230701 -end 20231001
-output ./ABI-L2-FDCF

goes-downloader.py -satellite GOES-18
-products ABI-L2-FDCM
-start 20230701 -end 20231001
-output ./ABI-L2-FDCM



# https://github.com/blaylockbk/goes2go