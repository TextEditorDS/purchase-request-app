const cdsCompile = require("@sap/cds/lib/compile/cds-compile");

module.exports = (srv) => {
  srv.before(['CREATE', 'UPDATE'], 'PurchaseRequests', (req) => {
    if (req.data.amount <= 0) {
      req.error(400, 'El monto debe ser mayor a cero', 'amount');
    }else if(req.data.amount > 100000){
        req.error(400, "No trabajamos con montos astronomicos! Paga más plata!", 'amount');
    }
  });
  srv.after('READ', 'PurchaseRequests', (results) => {
    const items = Array.isArray(results) ? results : [results];
    for(const pr of items){
        pr.isUrgent = pr.amount > 5000;
        pr.totalWithTaxSrv = pr.amount ? (pr.amount * 1.21).toFixed(2) : 0;
    }
  });
  srv.on('READ', 'Suppliers', async (req) => {
    const ext = await cds.connect.to('API_BUSINESS_PARTNER');
    return await ext.run(req.query);
  });
};
