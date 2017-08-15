# smhwR
Play the stock with R

## Package

Install the package `shiny`, `DT`, `quantmod`.

```
install.packages("shiny")
install.packages("DT")
install.packages("quantmod")
```

## Run

Run `smhw-tem.R` or 'smhw'

### smhw-tem.R

```
source("smhw-tem.R")
shinyApp(ui = ui, server = server)
```

### smhw

```
setwd("C:/[R Working Directory]")
library("shiny")
runApp("smhw")
```
