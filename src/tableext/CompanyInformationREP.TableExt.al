tableextension 50501 "Company Information REP" extends "Company Information"
{
    fields
    {
        field(50501; "Signature REP"; Blob)
        {
            Caption = 'Signature';
            DataClassification = CustomerContent;
        }
        field(50502; "Footer Agency REP"; Text[50])
        {
            Caption = 'Footer Agency';
            DataClassification = CustomerContent;
        }
        field(50503; "Footer VAT REP"; Text[50])
        {
            Caption = 'Footer VAT';
            DataClassification = CustomerContent;
        }
    }
}
