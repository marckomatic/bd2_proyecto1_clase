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
        let finalOutput = 'pokemon,move_pokemon,method_move,level_move,region\n';
        let csvLines = output.split('\n');
        let map = new Map();
        for(let i = 1; i < csvLines.length; i++){
            let csvLinesFields = csvLines[i].split(',');
            let pokemon = csvLinesFields[0];
            let move_pokemon = csvLinesFields[1];
            let method_move = Number(csvLinesFields[2]);
            let level_move = Number(csvLinesFields[3]);
            let region = Number(csvLinesFields[4]);

            let object = map.get(move_pokemon + ',' + method_move + ',' + pokemon);
            if(!object){
                map.set(move_pokemon + ',' + method_move + ',' + pokemon, 
                    {
                        pokemon: pokemon, 
                        move_pokemon: move_pokemon, 
                        method_move: method_move, 
                        level_move: level_move,
                        region: region == 0?'':region
                    });
            }
        }

        map.forEach((value, key, map)=>{
            finalOutput += value.pokemon + ',' + value.move_pokemon + ',' + value.method_move + ',' + value.level_move + ',' + value.region +'\n';
            console.log(value);
        })
        txtArea.value = finalOutput; 


    }
}
