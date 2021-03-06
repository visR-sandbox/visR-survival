% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vr_KM_est.R
\name{vr_KM_est}
\alias{vr_KM_est}
\title{Wrapper for Kaplan Meier analysis for an ADaM Basic Data Structure (BDS) for Time-to-Event analysis}
\usage{
vr_KM_est(data = NULL, strata = NULL, ...)
}
\arguments{
\item{data}{The name of the ADaM Basic Data Structure (BDS) for Time-to-Event analysis eg ADTTE. Rows in which AVAL or CNSR contain NA, are removed during analysis.}

\item{strata}{Character vector, representing the strata for Time-to-Event analysis eg TRT01P. When NULL, an overall analysis is performed.
Default is NULL.}

\item{...}{additional arguments passed on to the ellipsis of the call \code{survival::survfit.formula(data = data, formula = Surv(AVAL, 1-CNSR) ~ strata), ...)} .
Use \code{?survival::survfit.formula} and \code{?survival::survfitCI} for more information.}
}
\value{
survfit object, extended by elements PARAM/PARAMCD, ready for downstream processing in estimation or visualization functions and methods.
}
\description{
This function is a wrapper around \code{survival::survfit.formula} to perform a Kaplan-Meier analysis,
   based on the expected ADaM Basic Data Structure (BDS) for Time-to-Event analysis and assuming right-censored data.
   The function expects that the data has been filtered on the PARAM/PARAMCD of interest.
   Alternatively, PARAM/PARAMCD can be used in the \code{strata} argument. \cr
   The result is an object of class \code{survfit} which can be used in downstream functions and methods that rely on the \code{survfit} class.
   By default:
   \itemize{
     \item{The Kaplan Meier estimate is estimated directly (stype = 1).}
     \item{The cumulative hazard is estimated using the Nelson-Aalen estimator (ctype = 1): H.tilde = cumsum(x$n.event/x$n.risk).
     The MLE (H.hat(t) = -log(S.hat(t))) can't be requested.}
     \item{A two-sided pointwise 0.95 confidence interval is estimated using a log transformation (conf.type = "log").}
   }
}
\examples{
library(survival)
library(dplyr)
library(tidyr)

## No stratification
vr_KM_est(data = adtte)

## Stratified Kaplan-Meier analysis by `TRTP`
vr_KM_est(data = adtte, strata = "TRTP")

## Stratified Kaplan-Meier analysis by `TRTP` and `SEX` 
vr_KM_est(data = adtte, strata = c("TRTP", "SEX"))

## Stratification with one level
vr_KM_est(data = adtte, strata = "PARAMCD")

## Analysis on subset of adtte
vr_KM_est(data = adtte[adtte$SEX == "F", ])

## Modify the default analysis by using the ellipsis
vr_KM_est(data = adtte, strata = NULL, type = "kaplan-meier", conf.int = F, timefix = TRUE)
}
\references{
\url{https://https://github.com/therneau/survival}
}
\seealso{
\code{\link[survival]{survfit.formula} \link[survival]{survfitCI}}
}
\author{
Steven Haesendonckx
}
