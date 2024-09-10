// various functions

// string
// var myFirstString = 'mystring${storageAccountName }'
// var lowerCase = toLower(myFirstString)
// var upperCase = toUpper(myFirstString)
//var trimmed = trim(' spaces ')
//var sub = substring(trimmed, 0 ,2)
var myInteger = int('10')
var myString = string(10) 

// arrays
var myArray = [
  'myString'
  'myOtherString'
]

var mySecondArray = [
  'mySecondString'
  'mySecondOtherString'
]


var combinedArray = concat(myArray, mySecondArray)
var firstElement = first(myArray)
var arrayContains = contains(myArray, 'myString')
var isArrayEmpty  = empty(myArray)

var splitString = split('header1,header2,header3', ',')


//data conversions
var myBool = bool('true')

// scope functions
var myResourceGroupName = resourceGroup().name
var subscriptionId = subscription().id
