pageextension 50501 "Company Information REP" extends "Company Information"
{
    layout
    {
        addafter(Picture)
        {
            field("Signature REP"; "Signature REP")
            {
                ApplicationArea = all;
            }
            field("Footer Agency REP"; "Footer Agency REP")
            {
                ApplicationArea = all;
            }
            field("Footer VAT REP"; "Footer VAT REP")
            {
                ApplicationArea = All;
            }
        }
    }
}
