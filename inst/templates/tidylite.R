#' @title base spread
#' @description base spread mimics basic functionality of tidyr::spread
#' @param data data.frame
#' @param key column which will become the new columns
#' @param value column name which will populate new columns
#' @param convert type.convert will run on each result column if TRUE, Default: FALSE
#' @return data.frame
#' @examples
#' stocks <- data.frame(
#' time = as.Date('2009-01-01') + 0:9,
#' X = rnorm(10, 0, 1),
#' Y = rnorm(10, 0, 2),
#' Z = rnorm(10, 0, 4)
#' )
#' stocksm <- gatherlite(stocks,'stock', 'price', -1)
#' spreadlite(stocksm, 'stock', 'price')

#' # spreadlite and gatherlite are complements
#' df <- data.frame(x = c("a", "b"), y = c(3, 4), z = c(5, 6))
#' sdf <- spreadlite(df, 'x', 'y')
#' gatherlite(sdf, 'x', 'y', -1, na.rm = TRUE)
#'
#' # Use 'convert = TRUE' to produce variables of mixed type
#' df <- data.frame(row = rep(c(1, 51), each = 3),
#'                  var = c("Sepal.Length", "Species", "Species_num"),
#'                  value = c(5.1, "setosa", 1, 7.0, "versicolor", 2))
#'
#' str(spreadlite(df, 'var', 'value'))
#' str(spreadlite(df, 'var', 'value',convert = TRUE))
#' @rdname spreadlite
#' @author Jonathan Sidi
#' @export
#' @importFrom utils type.convert
spreadlite <- function(data,
                       key,
                       value,
                       convert = FALSE) {

  key_idx   <- find_idx(data,key)
  value_idx <- find_idx(data,value)

  if(length(key_idx)>1){
    data[key_idx[1]] <- apply(data[,key_idx],1,paste0,collapse = '_')
    data[,key_idx[-1]] <- NULL
    key_idx <- key_idx[1]
  }

  rhs <- data[, key_idx]

  s_ <- split(data,rhs)

  l <- lapply(s_,function(x,key_idx,value_idx){

    names(x)[value_idx] <- as.character(unique(x[[key_idx]]))

    x[,-key_idx]
  },key_idx = key_idx, value_idx = value_idx)

  ret <- l[[1]]

  for(i in 2:length(l))
    ret <- merge(ret,l[[i]],all = TRUE)

  if(convert){

    class_idx <- sapply(ret,function(y) all(grepl(pattern = '^[1-9]\\d*(\\.\\d+)?$',y)))

    for(i in which(class_idx))
      ret[[i]] <- as.numeric(ret[[i]],as.is = TRUE)


    for(i in which(!class_idx))
      ret[[i]] <- utils::type.convert(as.character(ret[[i]]),as.is = TRUE)
    }

  ret
}

#' @title base gather
#' @description base gather mimics basic functionality of tidyr::gather
#' @param data data.frame
#' @param key character, name of new key column, Default: 'key'
#' @param value character, name of new value column, Default: 'value'
#' @param columns column names or indicies or regex of them to gather,
#'  Default: NULL
#' @param regex boolean, indicates of columns is to be treated as a
#' regular expression, Default: FALSE
#' @param \dots parameters to pass to grep
#' @param na.rm boolean, apply na.omit to value column, Default: FALSE
#' @param convert boolean, apply type.convert to key column, Default: FALSE
#' @return data.frame
#' @examples
#'
#' mini_iris <- iris[c(1, 51, 101), ]
#'
#' # gather Sepal.Length, Sepal.Width, Petal.Length, Petal.Width
#'
#' gatherlite(mini_iris, key = 'flower_att', value = 'measurement',
#' columns = c('Sepal.Length', 'Sepal.Width', 'Petal.Length', 'Petal.Width'))
#'
#' gatherlite(mini_iris, key = 'flower_att', value = 'measurement',
#' columns = 1:4)
#'
#' gatherlite(mini_iris, key = 'flower_att', value = 'measurement',
#' columns = -5)
#'
#' gatherlite(mini_iris, key = 'flower_att', value = 'measurement',
#' columns = '^(Sepal|Petal)',regex = TRUE)
#'
#' @seealso
#'  \code{\link[utils]{type.convert}}
#' @rdname gatherlite
#' @author Jonathan Sidi
#' @export
#' @importFrom utils type.convert
#' @importFrom stats na.omit
gatherlite <- function(data,
                       key = 'key',
                       value = 'value',
                       columns = NULL,
                       regex = FALSE,
                       ...,
                       na.rm = FALSE,
                       convert = FALSE) {

  class_in <- class(data)

  cols_idx   <- find_idx(data, columns, regex = regex, ...)

  y <- data[-cols_idx]

  if(regex)
    columns <- names(data)[cols_idx]

  x <- c(data[columns])

  l <- lapply(names(x),function(nm,y){
    data.frame(y,NAME__ = nm,VALUE__ = x[[nm]],stringsAsFactors = FALSE)
  },y=y)

  ret <- do.call('rbind',l)

  if(na.rm)
    ret <- na.omit(ret)

  if(convert){

    class_key <- all(grepl(pattern = '^[1-9]\\d*(\\.\\d+)?$',ret$NAME__))

    if(class_key){
      ret$NAME__ <- utils::type.convert(ret$NAME__,as.is = TRUE)
    }else{
      ret$NAME__ <- utils::type.convert(as.character(ret$NAME__),as.is = TRUE)
    }

  }

  names(ret)[names(ret)=='NAME__'] <- key
  names(ret)[names(ret)=='VALUE__'] <- value

  class(ret) <- class_in

  ret
}

#' @title base unite
#' @description base unite mimics basic functionality of tidyr::unite
#' @param data data.frame
#' @param col character, name of the new column
#' @param columns column names or indicies or regex of them to gather,
#'  Default: NULL
#' @param regex boolean, indicates of columns is to be treated as a
#' regular expression, Default: FALSE
#' @param \dots parameters to pass to grep
#' @param sep character, separator to use between values, Default: '_'
#' @param remove boolean, if TRUE remove input columns from output object, Default: TRUE
#' @details the main difference between this lite version and the tidyr version is that the
#' new column is attached to the end of the data.frame and not before the index of the first column
#' that is to be united. Since this is mainly aesthetic it was not transfered over.
#' @return data.frame
#' @examples
#'
#' unitelite(mtcars, col = "vs_am", columns = c("vs","am"))
#'
#' unitelite(mtcars, col = "disp_drat", columns = '^d', regex = TRUE)
#'
#' @rdname unitelite
#' @author Jonathan Sidi
#' @export

unitelite <- function(data,
                      col,
                      columns = NULL,
                      regex = FALSE,
                      sep = '_',
                      remove = TRUE){

  class_in <- class(data)

  cols_idx   <- find_idx(data, columns, regex = regex, ...)

  ret <- data

  ret[col] <- apply(data[cols_idx],1,paste0,collapse = sep)

  if(remove)
    ret[cols_idx] <- NULL

  class(ret) <- class_in

  ret

}


find_idx <- function(data, obj = NULL, regex = FALSE,...){

  if(inherits(obj,'NULL'))
    return(1:ncol(data))


  if(inherits(obj,'character')){
    if(regex){
      return(grep(obj,names(data),...))
    }else{
      return(which(names(data)%in%obj))
    }
  }

  if(inherits(obj,c('numeric','integer'))){
    if(obj<0){

      (1:ncol(data))[obj]
    }else{
      obj
    }
  }

}
