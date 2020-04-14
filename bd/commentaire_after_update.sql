CREATE
	TRIGGER `commentaires_after_update` AFTER UPDATE 
	ON `commentaires` 
	FOR EACH ROW BEGIN
	
		IF NEW.efface THEN
			SET @changetype = 'Effacé';
		ELSE
			SET @changetype = 'Modifié';
		END IF;
    
		INSERT INTO commentaires_audit (commentaire_id, changetype) VALUES (NEW.id, @changetype);
		
    END$$

