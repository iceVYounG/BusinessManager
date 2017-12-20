//
//  UnitMetiodManager.m
//  CMCCMall
//
//  Created by user on 14-1-8.
//  Copyright (c) 2014年 cmcc. All rights reserved.
//

#import "UnitMetiodManager.h"
#import "SSKeychain.h"
#import "GTMBase641.h"

#define TIME_OUT (24*2*3600)  //48小时

const int START_YEAR =1901;
const int END_YEAR =2050;
static int32_t gLunarHolDay[]=
{
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1901
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X87, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1902
    0X96, 0XA5, 0X87, 0X96, 0X87, 0X87, 0X79, 0X69, 0X69, 0X69, 0X78, 0X78, //1903
    0X86, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X78, 0X87, //1904
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1905
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1906
    0X96, 0XA5, 0X87, 0X96, 0X87, 0X87, 0X79, 0X69, 0X69, 0X69, 0X78, 0X78, //1907
    0X86, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1908
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1909
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1910
    0X96, 0XA5, 0X87, 0X96, 0X87, 0X87, 0X79, 0X69, 0X69, 0X69, 0X78, 0X78, //1911
    0X86, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1912
    0X95, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1913
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1914
    0X96, 0XA5, 0X97, 0X96, 0X97, 0X87, 0X79, 0X79, 0X69, 0X69, 0X78, 0X78, //1915
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //1916
    0X95, 0XB4, 0X96, 0XA6, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X87, //1917
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X77, //1918
    0X96, 0XA5, 0X97, 0X96, 0X97, 0X87, 0X79, 0X79, 0X69, 0X69, 0X78, 0X78, //1919
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //1920
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X87, //1921
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X77, //1922
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X87, 0X79, 0X79, 0X69, 0X69, 0X78, 0X78, //1923
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //1924
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X87, //1925
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1926
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X87, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1927
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1928
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //1929
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1930
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X87, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1931
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1932
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1933
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1934
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1935
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1936
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1937
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1938
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1939
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1940
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1941
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1942
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1943
    0X96, 0XA5, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1944
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //1945
    0X95, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X77, //1946
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1947
    0X96, 0XA5, 0XA6, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //1948
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X79, 0X78, 0X79, 0X77, 0X87, //1949
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X77, //1950
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1951
    0X96, 0XA5, 0XA6, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //1952
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //1953
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X78, 0X79, 0X78, 0X68, 0X78, 0X87, //1954
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1955
    0X96, 0XA5, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //1956
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //1957
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1958
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1959
    0X96, 0XA4, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //1960
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1961
    0X96, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1962
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1963
    0X96, 0XA4, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //1964
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1965
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1966
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1967
    0X96, 0XA4, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //1968
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1969
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1970
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1971
    0X96, 0XA4, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //1972
    0XA5, 0XB5, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1973
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1974
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X77, //1975
    0X96, 0XA4, 0XA5, 0XB5, 0XA6, 0XA6, 0X88, 0X89, 0X88, 0X78, 0X87, 0X87, //1976
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //1977
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X78, 0X87, //1978
    0X96, 0XB4, 0X96, 0XA6, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X77, //1979
    0X96, 0XA4, 0XA5, 0XB5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //1980
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X77, 0X87, //1981
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //1982
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X77, //1983
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X87, //1984
    0XA5, 0XB4, 0XA6, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //1985
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //1986
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X79, 0X78, 0X69, 0X78, 0X87, //1987
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86, //1988
    0XA5, 0XB4, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //1989
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //1990
    0X95, 0XB4, 0X96, 0XA5, 0X86, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1991
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86, //1992
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //1993
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1994
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X76, 0X78, 0X69, 0X78, 0X87, //1995
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86, //1996
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //1997
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1998
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1999
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86, //2000
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //2001
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //2002
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //2003
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86, //2004
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //2005
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //2006
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //2007
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X87, 0X78, 0X87, 0X86, //2008
    0XA5, 0XB3, 0XA5, 0XB5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //2009
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //2010
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X78, 0X87, //2011
    0X96, 0XB4, 0XA5, 0XB5, 0XA5, 0XA6, 0X87, 0X88, 0X87, 0X78, 0X87, 0X86, //2012
    0XA5, 0XB3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X87, //2013
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //2014
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //2015
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X87, 0X88, 0X87, 0X78, 0X87, 0X86, //2016
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X87, //2017
    0XA5, 0XB4, 0XA6, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //2018
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //2019
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X86, //2020
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86, //2021
    0XA5, 0XB4, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //2022
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //2023
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X96, //2024
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86, //2025
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //2026
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //2027
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X96, //2028
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86, //2029
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //2030
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //2031
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X96, //2032
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X86, //2033
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X78, 0X88, 0X78, 0X87, 0X87, //2034
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //2035
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X96, //2036
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86, //2037
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //2038
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //2039
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X96, //2040
    0XA5, 0XC3, 0XA5, 0XB5, 0XA5, 0XA6, 0X87, 0X88, 0X87, 0X78, 0X87, 0X86, //2041
    0XA5, 0XB3, 0XA5, 0XB5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //2042
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //2043
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X88, 0X87, 0X96, //2044
    0XA5, 0XC3, 0XA5, 0XB4, 0XA5, 0XA6, 0X87, 0X88, 0X87, 0X78, 0X87, 0X86, //2045
    0XA5, 0XB3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X87, //2046
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //2047
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA5, 0X97, 0X87, 0X87, 0X88, 0X86, 0X96, //2048
    0XA4, 0XC3, 0XA5, 0XA5, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X86, //2049
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X78, 0X78, 0X87, 0X87 //2050
};




static double x_pi = 3.14159265358979324 * 3000.0 / 180.0 ;

/** 调整图片大小 */
UIImage * UIImageScaleToSize(UIImage *img, CGSize size)
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

/**
 @method 获取字符串value的宽度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param andWidth 限制字符串显示区域的宽度
 @result float 返回的宽度
 */
float HeightForString(NSString *value,float fontSize,float width)
{
    NSMutableParagraphStyle *paragrap = [[NSMutableParagraphStyle alloc]init];
    paragrap.lineBreakMode = NSLineBreakByWordWrapping;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragrap.copy};
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    //    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    
    return sizeToFit.height;
}


/**
 @method 获取指定宽度情况ixa，字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param andWidth 限制字符串显示区域的宽度
 @result float 返回的高度
 */
float WidthForString(NSString *value,float fontSize,float height)
{
    NSMutableParagraphStyle *paragrap = [[NSMutableParagraphStyle alloc]init];
    paragrap.lineBreakMode = NSLineBreakByWordWrapping;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragrap.copy};
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    
    //    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    
    return sizeToFit.width;
}


@implementation UnitMetiodManager
@synthesize accountModel;
+(UnitMetiodManager*)share
{
    static UnitMetiodManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UnitMetiodManager alloc]init];
    });
    return manager;
}

- (id)init
{
    if (self = [super init]) {
        self.timeOut = TIME_OUT;
    }
    return self;
}

//用户手机号展示
- (NSString *)showTheUserPhoneNumber
{
    if ((AccountInfo.terminalId.length > 7)) {
        
        NSString *showNum=[AccountInfo.terminalId stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return showNum;
        
    }else{
        return AccountInfo.terminalId;
    }
    
}

- (NSString *)showPhoneNumberWithNumString:(NSString *)numberString
{
    if (numberString.length > 7) {
        
        NSString *showNum = [numberString stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return showNum;
        
    }else{
        return numberString;
    }
    
}

- (BOOL) isUserSelectJSProvince{
    return [_CITY_CODE hasPrefix:@"32"];
}

- (BOOL) isUserSelectSZCity{
    return [_CITY_CODE isEqualToString:@"320500"];
}

+(BOOL)ifSuZhouMobile{
    if ([AccountInfo.area_code isEqualToString:@"320500"]) {
        return YES;
    }else{
        return NO;
    }
}

//判断接口返回字段是否存在值  防止crash
+ (BOOL)exitTheValueWithTheDiction:(NSDictionary *)dic withKey:(NSString *)key
{
    if(!dic){
        return NO;
    }
    //如果是null class则返回no
    if ([[dic objectForKey:key] isKindOfClass:[NSNull class]]) {
        return NO;
    }
    //如果存在值
    else if ([dic objectForKey:key]) {
        if ([[dic objectForKey:key] isKindOfClass:[NSString class]]) {
            //并且不是"<null>"字符串
            if (![[dic objectForKey:key] isEqualToString:@"<null>"]) {
                return YES;
            }
            else{
                return NO;
            }
        }
        else{
            return YES;
        }
    }
    else{
        return NO;
    }
}

//判断返回字段是否为Array类型  防止crash
+ (NSArray *)exchangeTheReturnValueToArray:(id)value
{
    if (value) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            
            return [NSArray array];
            
        }
        
        return (NSArray *)value;
        
    }
    
    return [NSArray array];
    
}


//把返回字段转换成string类型  防止crash
+ (NSString *)exchangeTheReturnValueToString:(id)value
{
    //add by yijing.niu
    if (value == nil)
    {
        return @"";
    }
    //end
    
    if ([value isKindOfClass:[NSString class]]) {
        if ([value isEqualToString:@"<null>"]||[value isEqualToString:@"<NULL>"]) {
            return @"";
        }
        else if([value isEqualToString:@"(null)"]||[value isEqualToString:@"(NULL)"]){
            return @"";
        }
        return (NSString *)value;
    }
    else if([value isKindOfClass:[NSNumber class]]){
        
        return [value stringValue];
    }
    else if ([value isKindOfClass:[NSNull class]]) {
        return @"";
    }
    else{
        return @"";
    }
}


+(BOOL)compareReturnStringWith:(NSString *)returnStr{
    if ([returnStr isEqual:@""]) {
        return YES;
    }else{
        return NO;
    }
}


/**
 *@存放订单超时时间
 **/
- (void)setTheOrederTimeOut:(NSUInteger)tOut
{
    self.timeOut = tOut;
}

/**
 *@时间戳转换成剩余天数
 **/
- (NSString *)getTheOrderTimeOut:(NSUInteger)time
{
    //设默认值
    if (time <= 0) {
        time = self.timeOut;
    }
    NSMutableString *timeStr = [NSMutableString stringWithCapacity:0];
    NSInteger left = time;
    NSInteger day = left/(3600*24);
    //天
    if (day > 0) {
        [timeStr appendString:[NSString stringWithFormat:@"%ld天",(long)day]];
    }
    left = left%(3600*24);
    NSInteger hour = left/3600;
    //时
    if (hour > 0) {
        [timeStr appendString:[NSString stringWithFormat:@"%ld时",(long)hour]];
    }
    left = left%3600;
    NSInteger minite = left/60;
    //分
    if (minite > 0) {
        [timeStr appendString:[NSString stringWithFormat:@"%ld分",(long)minite]];
    }
    left= left%60;
    NSInteger second = left;
    if (second > 0) {
        [timeStr appendString:[NSString stringWithFormat:@"%ld秒",(long)second]];
    }
    return timeStr;
}

#pragma mark -
#pragma mark 获取设备uuid
/**
 *   @获取设备uuid
 */
-(NSString*) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

/**
 *   @保存到钥匙串中
 */
- (NSString *)getChainkey
{
    //从钥匙串读取UUID：
    
//    NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString *retrieveuuid = [SSKeychain passwordForService:BUNDLE_ID account:@"user"];
    if (retrieveuuid.length == 0) {
        retrieveuuid = [self uuid];
        [SSKeychain setPassword: retrieveuuid
                     forService:BUNDLE_ID account:@"user"];
    }
    return retrieveuuid;
}


/**
 *@刷获取商城币、积分、话费等信息
 **/
- (PhoneAccountModel *)getTheUserInfoPayInfomaton
{
    if (!AccountInfo.isLogin) {
        return nil;
    }
    [self refreshInfoPayInfomaton];
    if (accountModel) {
        return accountModel;
    }
    return nil;
}

/**
 *@刷获取商城币、积分、话费等信息
 **/
- (void)reGetTheUserInfoPayInfomaton
{
    [self refreshInfoPayInfomaton];
    
}

- (NSString *) showExistFlow//展示剩余流量
{
    float flow = (self.totalFlow - self.useFlow)/1024;
    if (flow/1024 >= 1) {
        //以G为单位
        return [NSString stringWithFormat:@"%.2fG",flow/1024];
    }
    else{
        //以M为单位
        return [NSString stringWithFormat:@"%.2fM",flow];
    }
}

- (NSString *) showUsedFlow//展示已用流量
{
    float flow = self.useFlow/1024;
    if (flow/1024 >= 1) {
        //以G为单位
        return [NSString stringWithFormat:@"%.2fG",flow/1024];
    }
    else{
        //以M为单位
        return [NSString stringWithFormat:@"%.2fM",flow];
    }
}

/**
 *  删除用户登录时话费流量商城币等信息
 */
-(void)removeAllInfoPayInfomation
{
    if (accountModel)
    {
        accountModel = nil;
    }
    
}


#pragma mark - 请求接口数据
/**
 *@刷新商城币、积分、话费等信息
 **/
- (void)refreshInfoPayInfomaton
{
    //没登陆时不查询
    if (AccountInfo.terminalId.length > 0) {
    }
}


//摇晃效果
- (void)Shake:(UIView *)aView
{
    
    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    anim2.duration = 0.2f;
    
    anim2.fromValue = [NSNumber numberWithFloat:-0.2f];
    
    anim2.toValue = [NSNumber numberWithFloat:0.2f];
    
    anim2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    anim2.repeatCount = 5;
    
    anim2.autoreverses = YES;
    
    [aView.layer addAnimation:anim2 forKey:@"cornerRadius"];
}


//- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
//-(void)managerAlertView:(ManagerAlertView *)alertView buttonWithIndex:(NSInteger)buttonIndex
//{
//    if (nil != self.delegate&&[self.delegate respondsToSelector:@selector(popViewControllerWhenNetNoReachable)])
//    {
//        [self.delegate popViewControllerWhenNetNoReachable];
//    }
//
//}

/*
 * @brief H5分享为协议解析
 */
-(NSMutableArray *)parseH5Url:(NSString *)h5Url{
    NSMutableArray *array = [NSMutableArray array];
    if (h5Url.length>0) {
        h5Url = [h5Url stringByReplacingOccurrencesOfString:@"umsg://" withString:@""];
        
        NSString *discernNum = @"";
        NSString *imageUrl   = @"";
        NSString *content    = @"";
        NSString *url        = @"";
        array = [NSMutableArray arrayWithObjects:discernNum,imageUrl,content,url, nil];
        if ([h5Url hasPrefix:@"34"]) {
            [array removeAllObjects];
            [array addObjectsFromArray:[h5Url componentsSeparatedByString:@"_"]];
            imageUrl = [array objectAtIndex:1];
            imageUrl =[[NSString alloc]initWithData:[GTMBase641 decodeString:imageUrl] encoding:NSUTF8StringEncoding];
//            [[NSString alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]] encoding:NSUTF8StringEncoding];
            
            if (array.count>2) {
                content = [array objectAtIndex:2];
                content =[[NSString alloc]initWithData:[GTMBase641 decodeString:content] encoding:NSUTF8StringEncoding];
//                [[NSString alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:content]] encoding:NSUTF8StringEncoding];
            }
            
            if (array.count>3) {
                url = [array objectAtIndex:3];
                url =[[NSString alloc]initWithData:[GTMBase641 decodeString:url] encoding:NSUTF8StringEncoding];
//                [[NSString alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]] encoding:NSUTF8StringEncoding];
            }
            [array removeAllObjects];
            [array addObject:imageUrl];
            [array addObject:content];
            [array addObject:url];
            
        }
        
    }else{
        array = [NSMutableArray arrayWithObjects:@"",@"",@"", nil];
    }
    return array;
}

#pragma mark 本地保存收获地址ID
- (void)saveTheAddressKeyWith:(NSString *)addressId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:CHENK_VALUE(addressId) forKey:@"AddressId"];
    //将数据即时写入
    [userDefaults synchronize];
    
}

- (NSString *)getTheLocalAddressKey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    return [userDefaults objectForKey:@"AddressId"];
    
}

- (void)removeTheLocalAddressKey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:@"AddressId"];
    
}

- (void)saveTheHYITKey:(BOOL)isAutoLogin
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isAutoLogin forKey:@"HYIT"];
    //将数据即时写入
    [userDefaults synchronize];
    
}

- (BOOL)getTheLocalHYITKey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    return [userDefaults boolForKey:@"HYIT"];
}

+ (void)saveShowGuideKey:(BOOL)isShow
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isShow forKey:@"showGuide"];
    //将数据即时写入
    [userDefaults synchronize];
    
}

+ (BOOL)getShowGuideKey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    return [userDefaults boolForKey:@"showGuide"];
}

//本地保存是否自动登录
- (void)saveTheIsAutoLoginKey:(BOOL)isAutoLogin
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isAutoLogin forKey:@"isAutoLogin"];
    //将数据即时写入
    [userDefaults synchronize];
    
}

- (BOOL)getTheLocalIsAutoLoginKey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    return [userDefaults boolForKey:@"isAutoLogin"];
}

//本地保存是否已进入过附近
- (void)saveTheIntoNearByKey:(BOOL)isInto
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isInto forKey:@"isIntoNearBy"];
    //将数据即时写入
    [userDefaults synchronize];
    
}

- (BOOL)getTheIntoNearByKey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    return [userDefaults boolForKey:@"isIntoNearBy"];
}

//判断当前账号是否是移动账号
- (BOOL)isChinaMobileNumber
{
    if (AccountInfo.isLogin) {
        if ([AccountInfo.groupByDefaultMobileNum contains:@"YD"]) {

            return YES;
            
        }
    }

    return NO;
}

//判断当前账号是否是江西移动账号
- (BOOL)isJiangXiChinaMobileNumber
{
    if (AccountInfo.isLogin) {
        if ([@"ZGYD" isEqualToString:AccountInfo.groupByDefaultMobileNum] && [AccountInfo.area_code hasPrefix:@"36"]) {
            
            return YES;
            
        }
    }
    
    return NO;
}

//判断当前账号是否是江苏移动账号
- (BOOL)isJiangSuChinaMobileNumber
{
    if (AccountInfo.isLogin) {
        if ([@"JSYD" isEqualToString:AccountInfo.groupByDefaultMobileNum]) {
            
            return YES;
            
        }
    }
    
    return NO;
}


//点击判断是否绑定手机号（移动，联通，电信手机号都包括）
- (BOOL)isLinkPhoneNumber
{
    
    //第一步步判断是否是手机号码登录
    if (AccountInfo.terminalId.length > 0) {
        
        return YES;
        
    }

    return NO;
    
}

+(NSString *)getLunarSpecialDate:(int)iYear Month:(int)iMonth Day:(int)iDay {
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"小寒", @"大寒", @"立春", @"雨水", @"惊蛰", @"春分",
                          @"清明", @"谷雨", @"立夏", @"小满", @"芒种", @"夏至",
                          @"小暑", @"大暑", @"立秋", @"处暑", @"白露", @"秋分",
                          @"寒露", @"霜降", @"立冬", @"小雪", @"大雪", @"冬至", nil];
    int array_index = (iYear - START_YEAR)*12+iMonth -1 ;
    int64_t flag = gLunarHolDay[array_index];
    int64_t day;
    if(iDay <15)
        day= 15 - ((flag>>4)&0x0f);
    else
        day = ((flag)&0x0f)+15;
    int index = -1;
    if(iDay == day){
        index = (iMonth-1) *2 + (iDay>15? 1: 0);
    }
    if ( index >= 0 && index < [chineseDays count] ) {
        return [chineseDays objectAtIndex:index];
    } else {
        return nil;
    }
}

+(NSString*)getChineseCalendarWithDate:(NSDate *)date{
    
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSLog(@"%d_%d_%d  %@",localeComp.year,localeComp.month,localeComp.day, localeComp.date);
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    NSString *chineseCal_str =[NSString stringWithFormat: @"农历%@%@",m_str,d_str];
    
    
    return chineseCal_str;  
}

#pragma mark 拨打系统电话
- (void)callTheSystemTelephone:(NSString *)telNum
{
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType  isEqualToString:@"iPod touch"]||[deviceType  isEqualToString:@"iPad"]||[deviceType  isEqualToString:@"iPhone Simulator"]){
//        [OMGToast showWithText:@"您的设备不能拨打电话"];
        
    }
    else {
        
        if (telNum.length > 0) {
            
            
            NSString *callStr = [NSString stringWithFormat:@"tel://%@",telNum];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callStr]];
        }

     
    }
}

#pragma mark - 过滤html标签
- (NSString *)flattenHTML:(NSString *)html
{
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    } // while //
    
    return html;
}

#pragma mark - 显示特殊数量
- (NSString *)showSpecialCountWithCount:(NSInteger)count
{
    NSString *result;
    NSString *stringInt = [NSString stringWithFormat:@"%ld",(long)count];

    float floatString = [stringInt floatValue];

    if (count > 10000) {
        result = [NSString stringWithFormat:@"%.2f万",floatString/10000];
    }
    else{
        result = stringInt;
    }
   
    
    return result;
}

-(NSString *)getCurrentTime{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMddHHmmss"];
    return  [df stringFromDate:[NSDate date]];
}

#pragma mark 获取星期几
- (NSString *)getWeekDayWithDate:(NSDate *)date
{
    //获取日期
    NSArray *arrWeek = [NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSWeekdayCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger week = [comps weekday];

    return [NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:week]];
}

- (NSDate *)switchStringToDateWithString:(NSString *)dateStr
{
    //datestr格式为yyyyMMddHHmmss，在外面转换再传入
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *inputDate = [inputFormatter dateFromString:dateStr];
    
    return inputDate;
}

- (NSString *)switchDateToStringWithDate:(NSDate *)date type:(NSInteger)type
{

    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    
    if (type == 1) {
        [inputFormatter setDateFormat:@"M月dd日"];
    }
    
    NSString *inputDate = [inputFormatter stringFromDate:date];
    
    return inputDate;
}




@end
