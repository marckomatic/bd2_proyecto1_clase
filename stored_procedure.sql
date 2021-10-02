create or replace procedure search_pokemon (
        id IN INTEGER, caracteristica IN INTEGER)
    as rf_cursor_pokemon SYS_REFCURSOR;
begin
 
 CASE caracteristica
    WHEN 0 THEN
    
        open rf_cursor_pokemon for
        select DISTINCT p.ID_POKEMON, p.NAME_P, p.HEIGHT_P, p.WEIGHT_P, p.BASE_EXP, a.NAME_A, s.NAME_STATS, ps.BASE_STAT, ps.EFFORT, pm.LEVEL_MOVE, pm.METHOD_MOVE, m.ID_MOVE, m.NAME_MOVE, m.POWER_MOVE, m.PP, m.ACCURACY, pl.MIN_LEVEL, pl.MAX_LEVEL, l.NAME_L  from pokemon p
        inner join pokemon_specie pe on pe.id_especie  = p.specie
        inner join pokemon_ability pa on p.id_pokemon = pa.pokemon
        inner join ability a on a.id_ability = pa.ability
        inner join pokemon_stats ps on p.id_pokemon = ps.pokemon
        inner join stats s on s.id_stat = ps.stats
        inner join pokemon_move pm on p.id_pokemon = pm.pokemon 
        inner join movep m on m.id_move = pm.move_pokemon
        inner join pokemon_location pl on p.id_pokemon = pl.pokemon
        inner join location_p l on l.id_location = pl.location_p
        where p.id_pokemon = id
        ORDER BY pm.METHOD_MOVE, pm.LEVEL_MOVE;
   
    WHEN 1 THEN
    
        open rf_cursor_pokemon for
        SELECT p.ID_POKEMON, p.NAME_P, p.HEIGHT_P, p.WEIGHT_P, p.BASE_EXP from pokemon p
        where p.id_pokemon = id;

    WHEN 2 THEN
    
        open rf_cursor_pokemon for
        SELECT p.ID_POKEMON, p.NAME_P, a.NAME_A as habilidad from pokemon p
        inner join pokemon_ability pa on p.id_pokemon = pa.pokemon
        inner join ability a on a.id_ability = pa.ability
        where p.id_pokemon = id;
    
    WHEN 3 THEN
    
        open rf_cursor_pokemon for
        SELECT p.ID_POKEMON, p.NAME_P as Pokemon, s.NAME_STATS as Stat, ps.BASE_STAT as base, ps.EFFORT as effort FROM POKEMON p 
        inner join pokemon_stats ps on p.id_pokemon = ps.pokemon
        inner join stats s on s.id_stat = ps.stats
        where p.id_pokemon = id;
    WHEN 4 THEN
    
        open rf_cursor_pokemon for
        SELECT p.ID_POKEMON, p.NAME_P, pm.LEVEL_MOVE, pm.METHOD_MOVE, m.ID_MOVE, m.NAME_MOVE, m.POWER_MOVE, m.PP, m.ACCURACY FROM POKEMON p 
        inner join pokemon_move pm on p.id_pokemon = pm.pokemon 
        inner join movep m on m.id_move = pm.move_pokemon
        WHERE p.ID_POKEMON = id
        ORDER BY pm.METHOD_MOVE, pm.LEVEL_MOVE ;
    WHEN 5 THEN
    
        open rf_cursor_pokemon for
        SELECT p.ID_POKEMON, p.NAME_P, pl.MIN_LEVEL, pl.MAX_LEVEL, l.NAME_L from pokemon p
        inner join pokemon_location pl on p.id_pokemon = pl.pokemon
        inner join location_p l on l.id_location = pl.location_p
        where p.id_pokemon = id;
    ELSE  dbms_output.PUT_LINE ('caracteristica inválida');
    END CASE;

    dbms_sql.return_result(rf_cursor_pokemon);
   
end search_pokemon;

SET autoprint on;
EXECUTE search_pokemon(1,6)


