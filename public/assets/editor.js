var clipboard=new Object();$(init);function init(){$("#clearBtn").button({icons:{primary:"ui-icon-trash"}}).click(clear);$("#addBtn").button({icons:{primary:"ui-icon-plusthick"}}).click(add);$("#undoBtn").button({icons:{primary:"ui-icon-arrowreturnthick-1-w"}}).click(undo);$("#redoBtn").button({icons:{primary:"ui-icon-arrowreturnthick-1-e"}}).click(redo);$("#pasteBtn").button({icons:{primary:"ui-icon-clipboard"}}).click(paste);$("#renameBtn").button({icons:{primary:"ui-icon-pencil"}}).click(openRenameDialog);$("#renameDialog").dialog({autoOpen:false,modal:true,title:"Rename Sketch"})}function clear(){frames.canvasFrame.action();frames.canvasFrame.clear();frames.canvasFrame.save()}function add(){frames.canvasFrame.action();var a=$("#controlBox").val();var b=$("#controlBox option:selected").text();if(a=="checkbox"||a=="radio"){b=""}frames.canvasFrame.add(a,b,"");frames.canvasFrame.init();frames.canvasFrame.save()}function undo(){frames.canvasFrame.undo()}function redo(){frames.canvasFrame.redo()}function paste(a){frames.canvasFrame.pasteWidget()}function openRenameDialog(){$("#renameDialog").dialog("open")}function saved(){$("#saved").fadeIn("fast").fadeOut("medium")}function saveFailed(){$("#saveFailed").fadeIn("fast").fadeOut("medium")};