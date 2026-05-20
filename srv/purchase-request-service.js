module.exports = (srv) => {
  srv.before(['CREATE', 'UPDATE'], 'PurchaseRequests', (req) => {
    if (req.data.amount <= 0) {
      req.error(400, 'El monto debe ser mayor a cero', 'amount');
    }else if(req.data.amount > 100000){
        req.error(400, "No trabajamos con montos astronomicos! Paga más plata!", 'amount');
    }
  });
  srv.before('READ', 'PurchaseRequests', (req) => {
    console.log("Alguien está leyendo las solicitudes de compra...");
  });
};
