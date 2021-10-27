#GOL Conway's Game of Life 
#Rules to set:
#
#Any live cell with fewer than two live neighbours dies, as if by underpopulation.
#Any live cell with two or three live neighbours lives on to the next generation.
#Any live cell with more than three live neighbours dies, as if by overpopulation.
#Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
#
#These rules, which compare the behavior of the automaton to real life, can be condensed into the following:
#
#Any live cell with two or three live neighbours survives.
#Any dead cell with three live neighbours becomes a live cell.
#All other live cells die in the next generation. Similarly, all other dead cells stay dead.
#
#
#
#
#



function field ($state) {
    switch ($state) {
    1      {$output='[]'; break;}
    0      {$output='  '; break;}
    default     {$output='[ ]'; break;}
}
return $output;
}

function matrix ($table) {
$W = $table[0].Length 
$H = $table.Length

for ($j=0; $j -le ($h-1); $j++){
            for ($i=0; $i -le ($w-1); $i++) {
            Write-Host "$(field $($table[$j][$i]))" -NoNewline
            
            }
    write-Host
        }  
}


function TestConditions ($count) {
    switch ($count) {
        1 { 0; break }
        2 { 1; break }
        3 { 0; break } #was 1
        4 { 0; break }
        
        default {0;break}
    }

}

function StateTest ($table)
{   


    #Write-Host "----------"
    #$table
    
    #$ZeroTable = @((0, 0, 0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0, 0, 0))
    
    $W = $table[0].Length 
    $H = $table.Length
    #Multidimentional array
    #$TestZ = @()
    #$ent=@()
    #for ($j=0; $j -le ($H - 1);$j++) 
    #    {   
    #        for ($i=0; $i -le ($W - 1);$i++) 
    #        {  $ent += 0 }
    #        $TestZ += ,($ent); $ent=@()
    #    }
    #matrix $TestZ



    $TableOut=@()
    $E = @()
    for ($j=0; $j -le ($H - 1);$j++) 
        {   
            for ($i=0; $i -le ($W - 1);$i++) 
            {   
                $T = @()
                
            
                
                $T+= if ( $(try {$($table[$j-1][$i-1] )}catch{}) -eq $null) {0} else {$($table[$j-1][$i-1] )}  #upperrow  
                $T+= if ( $(try {$($table[$j-1][$i]   )}catch{}) -eq $null) {0} else {$($table[$j-1][$i]   )}  #upperrow 
                $T+= if ( $(try {$($table[$j-1][$i+1] )}catch{}) -eq $null) {0} else {$($table[$j-1][$i+1] )}  #upperrow 
                $T+= if ( $(try {$($table[$j][$i-1]   )}catch{}) -eq $null) {0} else {$($table[$j][$i-1]   )}  #samerow 
                $T+= if ( $(try {$($table[$j][$i+1]   )}catch{}) -eq $null) {0} else {$($table[$j][$i+1]   )}  #samerow 
                $T+= if ( $(try {$($table[$j+1][$i-1] )}catch{}) -eq $null) {0} else {$($table[$j+1][$i-1] )}  #lowerRow 
                $T+= if ( $(try {$($table[$j+1][$i]   )}catch{}) -eq $null) {0} else {$($table[$j+1][$i]   )}  #lowerRow 
                $T+= if ( $(try {$($table[$j+1][$i+1] )}catch{}) -eq $null) {0} else {$($table[$j+1][$i+1] )}  #lowerRow 
                
                $coutNeighburs = 0
                $T | % {$coutNeighburs = $coutNeighburs + $_}
                
                $T = TestConditions $coutNeighburs 
                #$ZeroTable[$j][$i]=$E
                $E += ,$T
                
            };
            $TableOut += ,($E); $E=@()
         
        }
    Return $TableOut
}


function WorldGenerate ($W,$H) 
                    {
                        $TestZ = @()
                        $ent=@()
                        for ($j=0; $j -le $H;$j++) 
                            {   
                                for ($i=0; $i -le $W;$i++) 
                                {  $ent += ,0 }
                                $TestZ += ,($ent); $ent=@()
                            }   return $TestZ     
                    }



$world = WorldGenerate 60 60
$counter = 0
while ($true) 
{   cls
    #GENERATORS
    
    
    
    if (($counter) -eq 1) {
        $world[40][17] = 1
        $world[40][18] = 1
        $world[49][21] = 1
        $world[49][21] = 1
    }
    
    Write-Host "Gen: $counter"
    matrix $world
    $world = StateTest $world
    $counter++
    #Start-sleep -milliseconds 5
}