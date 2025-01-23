# tmap
tmap is a very fast visualization library for large, high-dimensional data sets. Currently, tmap is available for Python. tmaps graph layouts are based on the [OGDF](https://ogdf.uos.de/) library.

### Tutorial and Documentation
See <a href="http://tmap.gdb.tools">http://tmap.gdb.tools</a>

## Notebook

## Examples
<img src="examples/drugbank/drugbank.jpg" height="290px"/>  <img src="examples/mnist/mnist.jpg" height="290px" />

| Name | Description |   |
| ---- | ----------- | - |
| NIPS Conference Papers | A tmap visualization showing the linguistic relationship between NIPS conference papers. | [view](http://tmap.gdb.tools/src/nips/nips_papers.html) |
| Project Gutenberg | A tmap visualization of the linguistic relationships between books and authors extracted from Project Gutenberg. | [view](http://tmap.gdb.tools/src/gutenberg/gutenberg.html) |
| MNIST | A visualization of the well known MNIST data set. No further explanation needed. | [view](http://tmap.gdb.tools/src/mnist/mnist.html) |
| Fashion MNIST | A visualization of a more fashionable variant of MNIST. | [view](http://tmap.gdb.tools/src/fmnist/fmnist.html) |
| Drugbank | A tmap visualization of all drugs registered in Drugbank. | [view](http://tmap.gdb.tools/src/drugbank/drugbank.html) |
| RNAseq | RNA sequencing data of tumor samples. Visualized using tmap. | [view](http://tmap.gdb.tools/src/rnaseq/rnaseq.html) |
| Flowcytometry | Flowcytometry data visualized using tmap. | [view](http://tmap.gdb.tools/src/flowcytometry/cyto.html) |
| MiniBooNE | tmap data visualization of a particle detection physics experiment.  | [view](http://tmap.gdb.tools/src/miniboone/miniboone.html) |


### Availability
| Language | Operating System | Status                 |
| -------- | ---------------- | ---------------------- |
| Python   | Linux            | Available              |
|          | Windows          | Available<sup>1</sup>  |
|          | macOS            | Available              |
| R        |                  | Unvailable<sup>2</sup> |

<span class="small"><sup>1</sup>Works with
[WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10)</span>
<span class="small"><sup>2</sup>FOSS R developers
[wanted](https://github.com/reymond-group/tmap)\!</span>

### Installation
tmap is installed using the conda package manager. Don't have conda? Download miniconda.

```bash
conda install -c tmap tmap
```

We suggest using faerun to plot the data layed out by tmap. But you can of course also use matplotlib (which might be to slow for large data sets and doesn't provide interactive features).

```bash
pip install faerun
# pip install matplotlib
```

## Build from source

In OSX, brew install `llvm` and `libom`
```bash 
brew install cmake
brew install llvm
brew install libomp
```

Then `cd` to the `ogdf-conda/src` directory and run the following commands:
```bash
cmake .
make -j12
```

Libraries available for wheels:
```mkdir lib
cp lib* lib/.
```

Finally, pip install the package:
```bash
pip install .
```

Or build distributables:
```
cd ../..
python setup.py sdist bdist_wheel
```

cf. https://bighatbio.atlassian.net/wiki/spaces/BB/pages/1268416519/Deploying+Custom+Python+Packages+to+CodeArtifact
