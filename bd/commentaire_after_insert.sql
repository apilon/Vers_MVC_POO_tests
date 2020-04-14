CREATE
	TRIGGER `commentaires_after_insert` AFTER INSERT 
	ON `commentaires` 
	FOR EACH ROW BEGIN
	
		IF NEW.efface THEN
			SET @changetype = 'Effacé';
		ELSE
			SET @changetype = 'Nouveau';
		END IF;
    
		INSERT INTO commentaires_audit (commentaire_id, changetype) VALUES (NEW.id, @changetype);
		
    END$$

