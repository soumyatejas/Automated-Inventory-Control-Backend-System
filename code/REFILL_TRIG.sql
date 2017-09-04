CREATE OR REPLACE TRIGGER REFILL_TRIG
AFTER INSERT
   ON REFILL_REQUEST_LINE
   FOR EACH ROW 

BEGIN
   FF_REFILL(:new.REQ_ID, :new.ITEM_NO, :new.ITEM_QTY);
END;