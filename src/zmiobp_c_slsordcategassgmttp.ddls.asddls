@AbapCatalog.sqlViewName: 'ZMIOBPCSOCATP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Categ. Assgmt. Cons. (TX)'

@Search.searchable: true

@Metadata.allowExtensions: true

@ObjectModel: {
   semanticKey: ['CategoryID'],
   createEnabled: true,
   deleteEnabled: true,
   updateEnabled: true
}

define view ZMIOBP_C_SlsOrdCategAssgmtTP
  as select from ZMIOBP_I_SlsOrdCategAssgmtTP

  association [1..1] to ZMIOBP_C_SalesOrderTP as _SalesOrder on $projection.SalesOrderUUID = _SalesOrder.SalesOrderUUID 
{
  key SalesOrderCategoryUUID,
      SalesOrderUUID,
      @Search.defaultSearchElement: true
      CategoryID,

      /* Associations */
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _SalesOrder,
      _SlsOrdCategory
}
