% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/two.b.pls.r
\name{two.b.pls}
\alias{two.b.pls}
\title{Two-block partial least squares analysis for Procrustes shape variables}
\usage{
two.b.pls(A1, A2, iter = 999, seed = NULL, print.progress = TRUE)
}
\arguments{
\item{A1}{A 3D array (p x k x n) containing Procrustes shape variables for the first block, or a matrix (n x variables)}

\item{A2}{A 3D array (p x k x n) containing Procrustes shape variables for the second block, or a matrix (n x variables)}

\item{iter}{Number of iterations for significance testing}

\item{seed}{An optional argument for setting the seed for random permutations of the resampling procedure.
If left NULL (the default), the exact same P-values will be found for repeated runs of the analysis (with the same number of iterations).
If seed = "random", a random seed will be used, and P-values will vary.  One can also specify an integer for specific seed values,
which might be of interest for advanced users.}

\item{print.progress}{A logical value to indicate whether a progress bar should be printed to the screen.
This is helpful for long-running analyses.}
}
\value{
Object of class "pls" that returns a list of the following:
  \item{r.pls}{The correlation coefficient between scores of projected values on the first
  singular vectors of left (x) and right (y) blocks of landmarks (or other variables).  This value can only be negative
  if single variables are input, as it reduces to the Pearson correlation coefficient.}
  \item{P.value}{The empirically calculated P-value from the resampling procedure.}
  \item{left.pls.vectors}{The singular vectors of the left (x) block}
  \item{right.pls.vectors}{The singular vectors of the right (y) block}
  \item{random.r}{The correlation coefficients found in each random permutation of the 
  resampling procedure.}
  \item{XScores}{Values of left (x) block projected onto singular vectors.}
  \item{YScores}{Values of right (y) block projected onto singular vectors.}
  \item{svd}{The singular value decomposition of the cross-covariances.  See \code{\link{svd}} for further details.}
  \item{A1}{Input values for the left block.}
  \item{A2}{Input values for the right block.}
  \item{A1.matrix}{Left block (matrix) found from A1.}
  \item{A2.matrix}{Right block (matrix) found from A2.}
  \item{permutations}{The number of random permutations used in the resampling procedure.}
  \item{call}{The match call.}
}
\description{
Function performs two-block partial least squares analysis to assess the degree of association between 
to blocks of Procrustes shape variables (or other variables)
}
\details{
The function quantifies the degree of association between two blocks of shape data as 
  defined by Procrustes shape variables using partial least squares (see Rohlf and Corti 2000). If geometric morphometric data are 
  used, it is assumed 
  that the landmarks have previously been aligned using 
  Generalized Procrustes Analysis (GPA) [e.g., with \code{\link{gpagen}}]. If other variables are used, they must be input as a 
  2-Dimensional matrix (rows = specimens, columns = variables).  It is also assumed that the separate inputs
  have specimens (observations) in the same order.  Additionally, if names for the objects are specified, these must be the same for both datasets.
  
 The generic function, \code{\link{plot}}, produces a two-block.pls plot.  This function calls \code{\link{plot.pls}}, which produces an ordination plot.  
 An additional argument allows one to include a vector to label points.  Starting with version 3.1.0, warpgrids are no longer available with \code{\link{plot.pls}}
 but after making a plot, the function returns values that can be used with \code{\link{picknplot.shape}} or a combination of 
\code{\link{shape.predictor}} and \code{\link{plotRefToTarget}} to visualize shape changes in the plot (via warpgrids).
 
 \subsection{For more than two blocks}{ 
If one wishes to consider 3+ arrays or matrices, there are multiple options.  First, one could perform multiple two.b.pls analyses and use
\code{\link{compare.pls}} to ascertain which blocks are more "integrated".  Second, one could use \code{\link{integration.test}} and perform a test that
averages the amount of integration (correlations) across multiple pairwise blocks.  Note that \code{\link{integration.test}} performed on two matrices or
arrays returns the same results as two.b.pls.  (Thus, \code{\link{integration.test}} is more flexible and thorough.)
}

 \subsection{Using phylogenies and PGLS}{ 
If one wishes to incorporate a phylogeny, \code{\link{phylo.integration}} is the function to use.  This function is exactly the same as \code{\link{integration.test}}
but allows PGLS estimation of PLS vectors.  Because \code{\link{integration.test}} can be used on two blocks, \code{\link{phylo.integration}} likewise allows one to
perform a phylogenetic two-block PLS analysis.
}
 
 \subsection{Notes for geomorph 3.0}{ 
There is a slight change in two.b.pls plots with geomorph 3.0.  Rather than use the shapes of specimens that matched minimum and maximum PLS
scores, major-axis regression is used and the extreme fitted values are used to generate deformation grids.  This ensures that shape deformations
are exactly along the major axis of shape covariation.  This axis is also shown as a best-fit line in the plot.
}

 \subsection{Notes for geomorph 3.0.4 and subsequent versions}{ 
 Compared to previous versions of geomorph, users might notice differences in effect sizes.  Previous versions used z-scores calculated with 
 expected values of statistics from null hypotheses (sensu Collyer et al. 2015); however Adams and Collyer (2016) showed that expected values 
 for some statistics can vary with sample size and variable number, and recommended finding the expected value, empirically, as the mean from the set 
 of random outcomes.  Geomorph 3.0.4 and subsequent versions now center z-scores on their empirically estimated expected values and where appropriate, 
 log-transform values to assure statistics are normally distributed.  This can result in negative effect sizes, when statistics are smaller than 
 expected compared to the average random outcome.  For ANOVA-based functions, the option to choose among different statistics to measure effect size 
 is now a function argument.
}
}
\examples{
data(plethShapeFood) 
Y.gpa<-gpagen(plethShapeFood$land)    #GPA-alignment    

#2B-PLS between head shape and food use data
PLS <-two.b.pls(Y.gpa$coords,plethShapeFood$food,iter=999)
summary(PLS)
plot(PLS)
 
 ### Visualize shape variation using picknplot.shape Because picknplot requires 
 ### user decisions, the following example
 ### is not run (but can be with removal of #).
 ### For detailed options, see the picknplot help file
 # picknplot.shape(plot(PLS))
 

}
\references{
Rohlf, F.J., and M. Corti. 2000. The use of partial least-squares to study covariation in shape. 
Systematic Biology 49: 740-753.

Collyer, M.L., D.J. Sekora, and D.C. Adams. 2015. A method for analysis of phenotypic change for phenotypes described 
by high-dimensional data. Heredity. 115:357-365.

Adams, D.C. and M.L. Collyer. 2016.  On the comparison of the strength of morphological integration across morphometric 
datasets. Evolution. 70:2623-2631.
}
\seealso{
\code{\link{integration.test}}, \code{\link{modularity.test}}, 
\code{\link{phylo.integration}}, and \code{\link{compare.pls}}
}
\author{
Dean Adams and Michael Collyer
}
\keyword{analysis}
