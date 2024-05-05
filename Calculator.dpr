//------------------------------------------------------------------------------
// PROJECT        : Fiat/Lancia Daiichi Mopar Radio Code Calculator
// VERSION        : 1.0
// AUTHOR         : Ernst Reidinga (ERDesigns)
// STATUS         : Open Source - Copyright © Ernst Reidinga
// COMPATIBILITY  : Windows 7, 8/8.1, 10, 11
// CREATED DATE   : 05/05/2024
//------------------------------------------------------------------------------

program Calculator;

uses
  Vcl.Forms,
  untMain in 'untMain.pas' {frmMain};

{$R *.res}

const
  Title: string = 'Fiat Daiichi Mopar Radio Code Calculator';

begin
  // Set the application title
  Application.Title := Title;
  // Initialize the application
  Application.Initialize;
  // Show the mainform on the taskbar
  Application.MainFormOnTaskbar := True;
  // Create the mainform
  Application.CreateForm(TfrmMain, frmMain);
  // Run the application
  Application.Run;
end.
