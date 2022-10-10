reportextension 50501 "RS - Sales Shipment GPO REPGPO" extends "RS - Sales Shipment GPO"
{
    RDLCLayout = './src/layout/RSSalesShipmentREPGPO.rdlc';

    dataset
    {
        add("Sales Shipment Header")
        {
            column(CompanyInfo_EMailCaptionREP; CompanyInfoG.fieldcaption("E-Mail")) { }
            column(CompanyInfo_EMailREP; CompanyInfoG."E-Mail") { }
            column(CompanyInfo_IndustrialClassificationCptREP; CompanyInfoG.fieldcaption("Industrial Classification")) { }
            column(CompanyInfo_IndustrialClassificationREP; CompanyInfoG."Industrial Classification") { }
            column(CompanyInfo_ResponsiblePersonREP; ResponsiblePerson) { }
            column(CompanyInfo_SignatureREP; CompanyInfoG."Signature REP") { }
            column(CompanyInfo_AgencyREP; CompanyInfoG."Footer Agency REP") { }
            column(CompanyInfo_VATREP; CompanyInfoG."Footer VAT REP") { }
            column(SalesShptHdr_ShipmentDateREPCaptionREP; fieldcaption("Shipment Date")) { }
            column(SalesShptHdr_ShipmentDateREP; format("Shipment Date")) { }
            column(SalesShptHdr_DueDateREPCaptionREP; fieldcaption("Due Date")) { }
            column(SalesShptHdr_DueDateREP; format("Due Date")) { }
            column(SalesShptHdr_GoodsIssuedREP; GoodsIssued) { }
            column(SalesShptHdr_CheckedInvoiceREP; CheckedInvoice) { }
            column(SalesShptHdr_CheckedGoodsAndDeliveryREP; CheckedGoodsAndDelivery) { }
        }

        modify("Sales Shipment Line")
        {
            trigger OnAfterAfterGetRecord()

            begin
                ItemLedgerEntryG.Reset();
                ItemLedgerEntryG.SetRange("Document No.", "Sales Shipment Line"."Document No.");
                ItemLedgerEntryG.SetRange("Item No.", "Sales Shipment Line"."No.");
                ItemLedgerEntryG.SetRange("Document Line No.", "Sales Shipment Line"."Line No.");
                CountILE := ItemLedgerEntryG.Count;

                if ItemLedgerEntryG.Findfirst() then;
            end;



        }

        add("Sales Shipment Line")
        {
            column(LotNoAndExpDateREP; LotNoAndExpDate) { }
            column(ILE_LotNoREP; ItemLedgerEntryG."Lot No.") { }
            column(ILE_ExpDateREP; ItemLedgerEntryG."Expiration Date") { }
            column(CertificateTxtREP; CertificateTxt) { }
            column(ILE_CertificateNoREP; ItemLedgerEntryG."Certificate No. PURCHGPO") { }
            column(ILE_CertificateDateREP; ItemLedgerEntryG."Certificate Date PURCHGPO") { }
        }


        addlast(PageLoop)
        {
            dataitem(BankAccountTemp; "Bank Account")
            {
                DataItemTableView = sorting("No.");
                UseTemporary = true;
                column(Name_BankcAccountREP; BankAccountTemp.NAme) { }
                column(BankAccountNoREP; BankAccountTemp."Bank Account No.") { }
            }
        }

    }

    trigger OnPreReport()

    begin
        CompanyInfoG.get();
        CompanyInfoG.CalcFields("Signature REP");
        FindBankAccountForPrint();
    end;


    local procedure FindBankAccountForPrint()
    begin
        BankAccountG.Reset();
        BankAccountG.SetRange("Print on Footer Document REP", true);
        if BankAccountG.FindSet() then
            repeat
                BankAccountTemp.Init();
                BankAccountTemp.TransferFields(BankAccountG);
                BankAccountTemp.Insert();
            until BankAccountG.Next() = 0;
    end;

    var
        CountILE: Integer;
        ItemLedgerEntryG: Record "Item Ledger Entry";
        CompanyInfoG: Record "Company Information";
        LotNoAndExpDate: Label 'Lot No - Exp. Date';
        CertificateTxt: Label 'Certificate';
        NoteTxt: Label 'Napomene o poreskom oslobođenju: ';
        GoodsIssued: Label 'Goods Issued with a declaration and instructions'; //Roba je izdata sa deklaracijom i uputstvom
        CheckedInvoice: Label 'Checked the Invoice __________________________'; //Fakturu kontrolisao
        CheckedGoodsAndDelivery: Label 'Controlled and delivered the goods __________________________'; //Robu kontrolisao i isporucio
        ResponsiblePerson: Label 'Responsible Person'; //Odgovorno lice

        //BankAccountTemp: Record "Bank Account" temporary;
        BankAccountG: Record "Bank Account";
}
