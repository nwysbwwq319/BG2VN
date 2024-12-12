# Welcome to BG<sup>2</sup>VN !
 [![license](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)](https://github.com/AbductiveLearning/ABLkit/blob/main/LICENSE)   ![Static Badge](https://img.shields.io/badge/MATLAB-green)

## Benchmark Graph Generator for Vital Node Recognition
BG<sup>2</sup>VN is a MATLAB toolbox designed for generating benchmark graphs that are composed of ground-truth vital nodes.

It provides a standardized evaluation benchmark for vital node mining algorithms and allows for adjustments to the graph's heterogeneity and aggregation
based on user requirements.
## Salient features
 - Provides a standard evaluation benchmark for vital node identification algorithms.
 - Allows for the specification of the graph's size and the number of vital nodes.
 - Enables customization of the graph's properties by adjusting parameters to modify the graph's heterogeneity and aggregation.

## Overview
![image](https://github.com/nwysbwwq319/BG2VN/blob/main/fig/fig1.jpg)


## Usage
### Input parameters:
| Parameter        | Functionality        |
|------------------|----------------------------------|
| `N`              |  the number of nodes in the graph |
| `p`              |  probability of edge generation between ordinary samples under the link_constraint |
|`mean`<br>`std_dev`| distance between each of the two distributions follows the gauss distribution N(`mean`,`std_dev`<sup>2</sup>) in horizontal and vertical coordinates |
|`interval`        | distance between any two means must not be less than interval|
|`Link_constraint` | (Optional, default=-1)<br>threshold for edge generation (`link_constraint`) |
|`Visualization`   |(Optional, default=false)<br> figure 1: Visualize graph of k sets of two-dimensional Gaussian distributed samples<br> figure 2: Visualize graph of  BG<sup>2</sup>VN |
#### `Link_constraint`
The length corresponding to the 30th percentile of all distances within a single sample set will be set as the default `link_constraint` 
#### `Visualization`
Two sample figures are given below:
- figure1
  ![image](https://github.com/nwysbwwq319/BG2VN/blob/main/fig/fig2.png)


- figure2
  ![image](https://github.com/nwysbwwq319/BG2VN/blob/main/fig/fig3.png)


### Output variables:
| Variables        | Functionality        |
|------------------|----------------------------------|
| `vital_idx`       |  index of the vital node |
| `adjacency_matrix`| the adjacency_matrix of BG<sup>2</sup>VN |

### Complete function
```matlab
 [vital_idx,adjacency_matrix]=BG2VN( k , N , p , mean , std_dev , interval , 'Link_constraint' , 'Visualization' ); 
```

### Example of use
```matlab
 [vital_idx,adjacency_matrix]=BG2VN(9,900,0.7,3,1,3,'Link_constraint',1.2,'Visualization',true); 
```

## Install

**Download the Toolbox**  
   - Locate the `BG2VN` directory and download the entire subfolder.
   - Or use the following Git command:
     ```bash
     git clone https://github.com/nwysbwwq319/BG2VN.git
     ```
 **Add the Toolbox to MATLAB Path**  
   - Unzip the downloaded folder (if downloaded as a ZIP file).
   - Open MATLAB.
   - Add the toolbox folder to the MATLAB path:
     - Use the MATLAB menu: **Home > Set Path > Add with Subfolders**. Select the unzipped folder.
     - Alternatively, use the following MATLAB command in the Command Window:
       ```matlab
       addpath(genpath('path_to_BG2VN'));
       savepath;
       ```
**Verify Installation & Start Using the Toolbox**  
   - After adding the toolbox to the MATLAB path, you can verify and use BG<sup>2</sup>VN by running the following command in MATLAB:
     ```matlab
     [vital_idx,adjacency_matrix]=BG2VN(9,900,0.7,3,1,3,'Link_constraint',1.2,'Visualization',true); 
     ```


