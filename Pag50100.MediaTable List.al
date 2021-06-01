page 50100 MediaView
{

    ApplicationArea = All;
    Caption = 'MediaTable List';
    PageType = List;
    SourceTable = MediaTable;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
                field(Image; Rec.Image)
                {
                    ToolTip = 'Specifies the value of the Image field';
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part(MediaFactbox; "Media FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Code" = FIELD(Code);
            }
        }
    }
}
