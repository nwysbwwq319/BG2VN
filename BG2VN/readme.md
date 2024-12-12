# File Descriptions
## `BG2VN.m`
- **Function**: This file serves as the main entry point of the project.
- **Dependencies**: Depends on `distance.m` `MU_rand.md` and `plot_BG2VN.m`.
- **Description**: It first generates k sets of two-dimensional Gaussian distributed samples of approximately equal size.The processed k samples are then converted into the adjacency matrix, and the index of the vital nodes along with the adjacency matrix are returned as the function's output.
- **Input parameters**:
  
| Parameter        | Functionality        |
|------------------|----------------------------------|
| `k`              |  the number of vital nodes |
| `N`              |  the number of nodes in the graph |
| `p`              |  probability of edge generation between ordinary samples under the link_constraint |
|`mean`<br>`std_dev`| distance between each of the two distributions follows the gauss distribution N(`mean`,`std_dev`<sup>2</sup>) in horizontal and vertical coordinates |
|`interval`        | distance between any two means must not be less than interval|
|`Link_constraint` | (Optional, default=-1) threshold for edge generation  |
|`Visualization`   |(Optional, default=false)<br> figure 1: Visualize graph of k sets of two-dimensional Gaussian distributed samples<br> figure 2: Visualize graph of  BG<sup>2</sup>VN |
- **Output parameters**:

| Parameter        | Functionality        |
|------------------|----------------------------------|
| `vital_idx`              |  index of the vital node |
| `adjacency_matrix`       |  the adjacency_matrix of BG2VN  |

- **How to Use**:
```matlab
 [vital_idx,adjacency_matrix]=BG2VN( k , N , p , mean , std_dev , interval , 'Link_constraint' , 'Visualization' ); 
```
- **Example to Use**:
```matlab
 [vital_idx,adjacency_matrix]=BG2VN(9,900,0.7,3,1,3,'Link_constraint',1.2,'Visualization',true); 
```


## `MU_rand.m`
- **Function**: Generate the means of two-dimensional Gaussian distributed samples for `BG2VN.m`.
- **Dependencies**: `distance.m`
- **Description**: For each new Gaussian distributed samples, generate its means and ensure that the distance to the existing Gaussian distributions follows the gauss distribution N(`mean`,`std_dev`<sup>2</sup>) in horizontal and vertical coordinates .
- **Input parameters**:

| Parameter        | Functionality        |
|------------------|----------------------------------|
| `MU_set`              | the set of means of all Gaussian distributions |
| `iter_gauss`          | the number of Gaussian distributions currently generated |
|`mean`<br>`std_dev`| distance between each of the two distributions follows the gauss distribution N(`mean`,`std_dev`<sup>2</sup>) in horizontal and vertical coordinates |
|`interval`        | distance between any two means must not be less than interval|
- **Output parameters**:

| Parameter        | Functionality        |
|------------------|----------------------------------|
| `MU`              |  coordinates of vital nodes |
- **How to Use**:
```matlab
[MU]=MU_rand(MU_set,iter_gauss,mean,std_dev,interval)
```
- **Example to Use**:
```matlab
[MU]=MU_rand(MU_set,3,3,1,3)
```


## `plot_BG2VN.m`
- **Function**: Visualization
- **Dependencies**: None
- **Description**: Generate the graph of k sets of two-dimensional Gaussian distributed samples and the graph of BG2VN.
- **Input parameters**:

| Parameter        | Functionality        |
|------------------|----------------------------------|
| `x`              |  the coordinates of each sample point |
| `N`              |  the number of nodes in the graph |
| `adjacency_matrix`   |  the adjacency_matrix of BG2VN  |
| `MU_set`         |  the set of means of all Gaussian distributions |

- **How to Use**:
```matlab
plot_BG2VN(x,N,adjacency_matrix,MU_set)
```



## `distance.m`
- **Function**: Calculate the distance between two sample points.
- **Dependencies**: None
- **Description**: Calculate the distance between node1 and node2 using<br>
  ((node1_x-node2_x)<sup>2</sup> + (node1_y-node2_y)<sup>2</sup>)<sup>0.5</sup>
- **Input parameters**:

| Parameter        | Functionality        |
|------------------|----------------------------------|
| `node1_x`              | the x-coordinate of node1 |
| `node1_y`              | the y-coordinate of node1 |
| `node2_x`              | the x-coordinate of node2 |
| `node2_y`              | the y-coordinate of node2 |

- **How to Use**:
```matlab
[value]=distance(node1_x,node1_y,node2_x,node2_y)
```
- **Example to Use**:
```matlab
[value]=distance(1,1,2,2)
```
