import sys
from PyQt5 import QtWidgets
from QHexEdit import QHexEdit, QHexEditData


class HexEdit(QHexEdit):

    def __init__(self, fileName=None):
        super(HexEdit, self).__init__()
        file = open(fileName)
        data = file.read()
        self.setData(data)
        self.setReadOnly(False)


if __name__ == '__main__':
    app = QtWidgets.QApplication(sys.argv)

    # QHexEditData* hexeditdata = QHexEditData::fromFile("data.bin");
    data = QHexEditData.fromFile('test.py')

    # QHexEdit* hexedit = new QHexEdit();
    # hexedit->setData(hexeditdata);
    mainWin = QHexEdit()
    mainWin.setData(data)

    mainWin.show()
    sys.exit(app.exec_())
