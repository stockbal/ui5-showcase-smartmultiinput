@AbapCatalog.sqlViewName: 'ZMIOBPISOCATP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Categ. Assgmt. (TX)'

@Search.searchable: true

@ObjectModel: {
  semanticKey:  [ 'CategoryID' ],
  writeActivePersistence: 'ZMIOBP_SORDC',
  createEnabled: true,
  deleteEnabled: true,
  updateEnabled: true,
  writeDraftPersistence: 'ZMIOBP_SORDC_D'
}

define view ZMIOBP_I_SlsOrdCategAssgmtTP
  as select from zmiobp_sordc

  association [1..1] to ZMIOBP_I_SalesOrderTP as _SalesOrder on $projection.SalesOrderUUID = _SalesOrder.SalesOrderUUID
  association [1..1] to ZMIOBP_I_Category as _SlsOrdCategory on $projection.CategoryID = _SlsOrdCategory.CategoryID
{
      @ObjectModel.readOnly: true
  key salesordercategoryuuid as SalesOrderCategoryUUID,
      @ObjectModel.readOnly: true
      salesorderuuid         as SalesOrderUUID,
      @Search.defaultSearchElement: true
      @ObjectModel.foreignKey.association: '_SlsOrdCategory'
      categoryid             as CategoryID,

      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _SalesOrder,
      _SlsOrdCategory
}
