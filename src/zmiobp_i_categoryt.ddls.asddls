@AbapCatalog.sqlViewName: 'ZMIOBPICATT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Text for Category of Sales Order'

@ObjectModel.dataCategory: #TEXT

define view ZMIOBP_I_CategoryT
  as select from zmiobp_categt
  association to ZMIOBP_I_Category as _Category on $projection.CategoryID = _Category.CategoryID
{
      @ObjectModel.foreignKey.association: '_Category'
  key categoryid as CategoryID,
      @Semantics.language: true
  key language   as Language,
      @Semantics.text: true
      text       as Text,

      _Category
}
