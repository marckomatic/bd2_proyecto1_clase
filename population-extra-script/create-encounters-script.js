window.onload = function(){
    var inputFile = document.getElementById('csv-input');

    var button = document.getElementById('transformate');

    var txtArea = document.getElementById('output');

    var output = 'No file selected.';

    inputFile.addEventListener('change', function(){
           
        var fr=new FileReader();
        fr.onload=function(){
            output=fr.result;
        }
          
        fr.readAsText(this.files[0]);
    });

    button.onclick = function(event){
        let finalOutput = 'location_p,pokemon,min_level,max_level\n';
        let csvLines = output.split('\n');
        let map = new Map();
        for(let i = 1; i < csvLines.length; i++){
            let csvLinesFields = csvLines[i].split(',');
            let locationAreaId = csvLinesFields[2];
            let pokemonId = csvLinesFields[4];
            let minLevel = Number(csvLinesFields[5]);
            let maxLevel = Number(csvLinesFields[6]);
            let object = map.get(locationAreaId + ',' + pokemonId);
            if(object){
                if(minLevel < object.minLevel){
                    object.minLevel = minLevel;
                }
                if(maxLevel > object.maxLevel){
                    object.maxLevel = maxLevel;
                }
            }else{
                map.set(locationAreaId + ',' + pokemonId, 
                    {
                        location_p: locationAreaId, 
                        pokemon: pokemonId, 
                        minLevel: minLevel, 
                        maxLevel: maxLevel
                    });
            }
        }

        map.forEach((value, key, map)=>{
            finalOutput += value.location_p + ',' + value.pokemon + ',' + value.minLevel + ',' + value.maxLevel +'\n';
            console.log(value);
        })
        txtArea.value = finalOutput; 


    }
}
