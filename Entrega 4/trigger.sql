-- Trigger a

create or replace function check_fornecedor()
  returns trigger as $$
declare f_aux integer;
begin

  select forn_primario into f_aux
  from produto
  where forn_primario = new.nif and ean = new.ean;
	if new.nif = f_aux
	THEN RAISE EXCEPTION 'o fornecedor com o nif % e fornecedor primario do produto %', new.nif, new.ean;
	end if;
	return null;
end
$$ language plpgsql;

create trigger check_forne after insert on fornece_sec for each row
	execute procedure check_fornecedor();

-- b

CHECK (localtimestamp >= instante)
