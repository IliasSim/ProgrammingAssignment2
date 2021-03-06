makeCacheMatrix <-function(x=matrix()){
    m<-matrix()
    set<-function(y){ 
        x<<-y #setting the matrix to be inversed 
        #in the parent environment(p.env) 
        m<<-matrix() #seting the m to empty matrix 
        #in the p.env.This procedure clean any previus
        #values had been cached by cacheSolve in the p.env
    }
    get<-function() x #geting the matrix to be inversed from the p.env
    setinverse<-function(inverse) m<<-inverse#setting the function in the p.env 
    getinverse<-function() m #getting the result of the function in p.env
    list(set = set, get = get,  #create a list which gives
         setinverse = setinverse,#names in each function defined bove
         getinverse = getinverse)
}
cacheSolve<-function(x,...){
    m<-x$getinverse() #gets the value stored in p.env from makeCacheMatrix
    if(!is.na(det(m))){# assuming that matrix supplied is invertible det
        message("getting cached data") #of inverse matrix,if cached, is numeric
        return(m)# getting cached inverted matrix
    }
    data<-x$get()# if inverted matrix no exist n p.env here we get the 
    m<-solve(data)# the x matrix of makeCacheMatrix and perform the solve function 
    x$setinverse(m) #here the results are cashed for future use 
    m # getting the calculated inverse matrix
}
