create or replace procedure search_pokemon (
        id IN INTEGER, caracteristica IN INTEGER)
    as rf_cursor_pokemon SYS_REFCURSOR;
    rf_cursor_postEv SYS_REFCURSOR;
    
    existe int := 0;
    preevo int := null;
    postev int := null;
    especie int := null;
    namepreevo varchar(3000) := null;
    namepostev varchar(3000) := null;
    original varchar(3000) := null;

        
    
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
         dbms_sql.return_result(rf_cursor_pokemon);
   
    WHEN 1 THEN
    
        open rf_cursor_pokemon for
        SELECT p.ID_POKEMON, p.NAME_P, p.HEIGHT_P, p.WEIGHT_P, p.BASE_EXP from pokemon p
        where p.id_pokemon = id;
         dbms_sql.return_result(rf_cursor_pokemon);

    WHEN 2 THEN
    
        open rf_cursor_pokemon for
        SELECT p.ID_POKEMON, p.NAME_P, a.NAME_A as habilidad from pokemon p
        inner join pokemon_ability pa on p.id_pokemon = pa.pokemon
        inner join ability a on a.id_ability = pa.ability
        where p.id_pokemon = id;
         dbms_sql.return_result(rf_cursor_pokemon);
    
    WHEN 3 THEN
    
        open rf_cursor_pokemon for
        SELECT p.ID_POKEMON, p.NAME_P as Pokemon, s.NAME_STATS as Stat, ps.BASE_STAT as base, ps.EFFORT as effort FROM POKEMON p 
        inner join pokemon_stats ps on p.id_pokemon = ps.pokemon
        inner join stats s on s.id_stat = ps.stats
        where p.id_pokemon = id;
         dbms_sql.return_result(rf_cursor_pokemon);
    WHEN 4 THEN
    
        open rf_cursor_pokemon for
        SELECT p.ID_POKEMON, p.NAME_P, pm.LEVEL_MOVE, pm.METHOD_MOVE, m.ID_MOVE, m.NAME_MOVE, m.POWER_MOVE, m.PP, m.ACCURACY FROM POKEMON p 
        inner join pokemon_move pm on p.id_pokemon = pm.pokemon 
        inner join movep m on m.id_move = pm.move_pokemon
        WHERE p.ID_POKEMON = id
        ORDER BY pm.METHOD_MOVE, pm.LEVEL_MOVE ;
         dbms_sql.return_result(rf_cursor_pokemon);
    WHEN 5 THEN
    
        open rf_cursor_pokemon for
        SELECT p.ID_POKEMON, p.NAME_P, pl.MIN_LEVEL, pl.MAX_LEVEL, l.NAME_L from pokemon p
        inner join pokemon_location pl on p.id_pokemon = pl.pokemon
        inner join location_p l on l.id_location = pl.location_p
        where p.id_pokemon = id;
         dbms_sql.return_result(rf_cursor_pokemon);
    WHEN 6 THEN
    
        
        select count(*) into existe from pokemon 
        where id_pokemon = id;
        dbms_output.PUT_LINE ('PRE EVOLUCIONES');
        dbms_output.PUT_LINE ('-----------------------------------------------------------------------------------------------------------------');
        
        if existe > 0 then
            select  pe.id_especie  into preevo from pokemon p
            inner join pokemon_specie pe on pe.id_especie  = p.specie
            WHERE p.id_pokemon = id;

            WHILE preevo != null or preevo > 0
            LOOP
                
                select name_specie into namepreevo from pokemon_specie
                where id_especie = preevo;
                dbms_output.PUT_LINE ( '    '|| namepreevo);
                
                
                select id_preevo into preevo from pokemon_specie
                where id_especie = preevo;
               
            END LOOP;
        end if;
        dbms_output.PUT_LINE ('--------------------------------------------------------------------------------------------------------------------------');
        
    WHEN 7 THEN
            --open rf_cursor_pokemon for
                select p.specie into especie 
                from pokemon p
                where p.id_pokemon = id;
                
                select p.name_p into original 
                from pokemon p
                where p.id_pokemon = id;
                
                    open rf_cursor_pokemon for
                    select p.id_especie 
                    from pokemon_specie p
                    where p.id_preevo = especie;
                
                    LOOP
                        FETCH rf_cursor_pokemon INTO postev;
                        IF rf_cursor_pokemon%NOTFOUND THEN
                        EXIT;
                        END IF;
                        dbms_output.PUT_LINE ( '    '|| original || '  :');
                        select p.NAME_SPECIE into namepostev
                        from pokemon_specie p
                        where p.ID_ESPECIE = postev;
                
                        
                        dbms_output.PUT_LINE ( '    '|| namepostev);
                        
                                               
                        -- rf_cursor_postEv
                        open rf_cursor_postEv for
                        select p.id_especie 
                        from pokemon_specie p
                        where p.id_preevo = postev;
                        
                        LOOP
                        FETCH rf_cursor_postEv INTO postev;
                        IF rf_cursor_postEv%NOTFOUND THEN
                        EXIT;
                        END IF;
                        select p.NAME_SPECIE into namepostev
                        from pokemon_specie p
                        where p.ID_ESPECIE = postev;
                
                        
                        dbms_output.PUT_LINE ( '    '|| namepostev);
                        end loop;
                        
                        
                        
                        
                        dbms_output.PUT_LINE ('--------------------------------------------------------------------------------------------------------------------------');

                    END LOOP;
            
    ELSE  dbms_output.PUT_LINE ('caracteristica inválida');
    END CASE;

   
end search_pokemon;

SET serveroutput ON
SET autoprint on;
EXECUTE search_pokemon(137,7)

select id_especie, name_specie, id_preevo from pokemon_specie
where id_preevo = 6;

select * from pokemon;

