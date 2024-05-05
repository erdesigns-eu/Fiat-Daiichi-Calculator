//------------------------------------------------------------------------------
// UNIT           : untMain.pas
// CONTENTS       : Radio Code Calculator for Fiat/Lancia Daiichi Mopar
// VERSION        : 1.0
// TARGET         : Embarcadero Delphi 11 or higher
// AUTHOR         : Ernst Reidinga (ERDesigns)
// STATUS         : Open Source - Copyright © Ernst Reidinga
// COMPATIBILITY  : Windows 7, 8/8.1, 10, 11
// RELEASE DATE   : 05/05/2024
//------------------------------------------------------------------------------
unit untMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

//------------------------------------------------------------------------------
// CLASSES
//------------------------------------------------------------------------------
type
  /// <summary>
  ///   Radio Code Calculator Main Form
  /// </summary>
  TfrmMain = class(TForm)
    bvImageLine: TBevel;
    imgLogo: TImage;
    pnlBottom: TPanel;
    bvPnlLine: TBevel;
    btnAbout: TButton;
    btnCalculate: TButton;
    pnlSerialNumber: TPanel;
    lblSerialNumber: TLabel;
    edtSerialNumber: TEdit;
    pnlRadioCode: TPanel;
    lblRadioCode: TLabel;
    edtRadioCode: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnCalculateClick(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

//------------------------------------------------------------------------------
// FORM ON CREATE
//------------------------------------------------------------------------------
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  // Set the caption
  Caption := Application.Title;
  // Set the labels captions
  lblSerialNumber.Caption := 'Serial Number:';
  lblRadioCode.Caption    := 'Radio Code:';
  // Set the button captions
  btnCalculate.Caption := 'Calculate..';
  btnAbout.Caption := 'About..';
end;

//------------------------------------------------------------------------------
// CALCULATE RADIO CODE
//------------------------------------------------------------------------------
procedure TfrmMain.btnCalculateClick(Sender: TObject);

  function Validate(const Input: string; var ErrorMessage: string): Boolean;
  begin
    // Initialize result
    Result := True;
    // Clear the error message
    ErrorMessage := '';

    // Serial with leading character
    if (Length(Input) = 5) then
    begin
      // Make sure the input starts with a digit
      if not CharInSet(Input[1], ['0'..'9', 'a'..'z', 'A'..'Z']) then
      begin
        ErrorMessage := 'First character must be a digit or a character!';
        Exit(False);
      end;

      // Make sure the second character is a digit
      if not (CharInSet(Input[2], ['0'..'9'])) then
      begin
        ErrorMessage := 'Second character must be a digit!';
        Exit(False);
      end;

      // Make sure the third character is a digit
      if not (CharInSet(Input[3], ['0'..'9'])) then
      begin
        ErrorMessage := 'Third character must be a digit!';
        Exit(False);
      end;

      // Make sure the fourth character is a digit
      if not (CharInSet(Input[4], ['0'..'9'])) then
      begin
        ErrorMessage := 'Fourth character must be a digit!';
        Exit(False);
      end;

      // Make sure the fifth character is a digit
      if not (CharInSet(Input[5], ['0'..'9'])) then
      begin
        ErrorMessage := 'Fifth character must be a digit!';
        Exit(False);
      end;
    end else

    // Serial without leading character
    if (length(Input) = 4) then
    begin
      // Make sure the input starts with a digit
      if not CharInSet(Input[1], ['0'..'9']) then
      begin
        ErrorMessage := 'First character must be a digit!';
        Exit(False);
      end;

      // Make sure the second character is a digit
      if not (CharInSet(Input[2], ['0'..'9'])) then
      begin
        ErrorMessage := 'Second character must be a digit!';
        Exit(False);
      end;

      // Make sure the third character is a digit
      if not (CharInSet(Input[3], ['0'..'9'])) then
      begin
        ErrorMessage := 'Third character must be a digit!';
        Exit(False);
      end;

      // Make sure the fourth character is a digit
      if not (CharInSet(Input[4], ['0'..'9'])) then
      begin
        ErrorMessage := 'Fourth character must be a digit!';
        Exit(False);
      end;
    end else

    // Make sure the input is 5 characters long
    begin
      ErrorMessage := 'Must be 5 characters long!';
      Exit(False);
    end;
  end;

const
  InvalidSerial: string = 'Invalid';

var
  ErrorMessage: string;
  I: Integer;
  SNArr: array[0..3] of Integer;
  Input: string;
begin
  // Clear the error message
  ErrorMessage := '';

  // Check if the serial number is valid
  if not Validate(edtSerialNumber.Text, ErrorMessage) then
  begin
    MessageBox(Handle, PChar(ErrorMessage), PChar(Application.Title), MB_ICONWARNING + MB_OK);
    Exit;
  end;

  // Initialize SNArr with default values
  FillChar(SNArr, SizeOf(SNArr), 0);

  // Set the input
  Input := edtSerialNumber.Text;
  // Trim the first character if needed
  if Length(Input) = 5 then Input := Copy(Input, 2, 4);

  // Iterate through each character in the input string
  for I := 1 to Length(Input) do
  begin
    // Update SNArr based on the character and index
    case I of
      1: SNArr[3] := 10 - StrToInt(Input[I]);
      2: SNArr[2] := 9 - StrToInt(Input[I]);
      3: SNArr[1] := 9 - StrToInt(Input[I]);
      4: SNArr[0] := 9 - StrToInt(Input[I]);
    end;
  end;

  // Format the code for the output
  edtRadioCode.Text := Format('%d%d%d%d', [SNArr[0], SNArr[1], SNArr[2], SNArr[3]]);
end;

//------------------------------------------------------------------------------
// SHOW ABOUT DIALOG
//------------------------------------------------------------------------------
procedure TfrmMain.btnAboutClick(Sender: TObject);
const
  AboutText: string =
    'Fiat Daiichi Mopar Radio Code Calculator' + sLineBreak + sLineBreak +
    'by Ernst Reidinga - ERDesigns'            + sLineBreak +
    'Version 1.0 (05/2024)';
begin
  MessageBox(Handle, PChar(AboutText), PChar(Caption), MB_ICONINFORMATION + MB_OK);
end;

end.
