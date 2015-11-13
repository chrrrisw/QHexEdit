
%Module(name=QHexEdit, version=1)

%Import QtCore/QtCoremod.sip
%Import QtGui/QtGuimod.sip

%If (Qt_5_0_0 -)
%Import QtWidgets/QtWidgetsmod.sip
%End

class QHexEditData : QObject
{
%TypeHeaderCode
#include <qhexeditdata.h>
%End

    public:
        enum ActionType { None = 0, Insert = 1, Remove = 2, Replace = 3 };

        QUndoStack* undoStack();
        qint64 length() const;
        bool isReadOnly() const;

    private:
        explicit QHexEditData(QIODevice* iodevice, QObject * /TransferThis/ = 0);
        ~QHexEditData();

    public slots:
        bool save();
        bool saveTo(QIODevice* iodevice);

    public:
        static QHexEditData* fromDevice(QIODevice* iodevice);
        static QHexEditData* fromFile(QString filename);
        static QHexEditData* fromMemory(const QByteArray& ba);

    signals:
        void dataChanged(qint64 offset, qint64 size, QHexEditData::ActionType reason);

};


class QHexEditDataReader : QObject
{
%TypeHeaderCode
#include <qhexeditdatareader.h>
%End
    public:
        explicit QHexEditDataReader(QHexEditData* hexeditdata, QObject* /TransferThis/ = 0);
        const QHexEditData* hexEditData() const;
        uchar at(qint64 pos);
        qint64 indexOf(const QByteArray& ba, qint64 start);
        QByteArray read(qint64 pos, qint64 len);
        QString readString(qint64 pos, qint64 maxlen = -1);
        quint16 readUInt16(qint64 pos, QSysInfo::Endian endian = QSysInfo::ByteOrder);
        quint32 readUInt32(qint64 pos, QSysInfo::Endian endian = QSysInfo::ByteOrder);
        quint64 readUInt64(qint64 pos, QSysInfo::Endian endian = QSysInfo::ByteOrder);
        qint16 readInt16(qint64 pos, QSysInfo::Endian endian = QSysInfo::ByteOrder);
        qint32 readInt32(qint64 pos, QSysInfo::Endian endian = QSysInfo::ByteOrder);
        qint64 readInt64(qint64 pos, QSysInfo::Endian endian = QSysInfo::ByteOrder);

    private slots:
        void onDataChanged(qint64 offset, qint64, QHexEditData::ActionType);

    private:
        void bufferizeData(qint64 pos);
        bool inBuffer(qint64 pos);
        bool needsBuffering(qint64 pos);

};


class QHexEdit : QFrame
{
%TypeHeaderCode
#include <qhexedit.h>
%End

    public:
        explicit QHexEdit(QWidget * /TransferThis/ = 0);
        bool readOnly();
        int addressWidth();
        int visibleLinesCount();
        QHexEditData *data();
        qint64 indexOf(QByteArray &ba , qint64 start = 0);
        qint64 baseAddress();
        qint64 cursorPos();
        qint64 selectionStart();
        qint64 selectionEnd();
        qint64 selectionLength();
        qint64 visibleStartOffset();
        qint64 visibleEndOffset();

        void setFont(const QFont &f);
        void setLineColor(const QColor &c);
        void setHexColor(const QColor &c);
        void setAlternateHexColor(const QColor &c);
        void setHighlightColor(const QColor &c);
        void setAddressForeColor(const QColor &c);
        void setAddressBackColor(const QColor &c);
        void setAlternateLineColor(const QColor &c);

        void setBaseAddress(qint64 ba);

    signals:
        void visibleLinesChanged();
        void positionChanged(qint64 offset);
        void selectionChanged(qint64 length);
        void bytesChanged(qint64 pos);
        void verticalScrollBarValueChanged(int value);
        void widthChanged(int width);

    public slots:
        void undo();
        void redo();
        void cut();
        void copy();
        void copyHex();
        void paste();
        void pasteHex();
        void selectAll();
        void setReadOnly(bool b);
        void setCursorPos(qint64 pos);
        void setData(QHexEditData *hexeditdata);
        void selectPos(qint64 pos);
        void setSelection(qint64 start, qint64 end);
        void setSelectionLength(qint64 start , qint64 length);
        void highlightBackground(qint64 start, qint64 end, const QColor& color);
        void highlightForeground(qint64 start, qint64 end, const QColor& color);
        void clearHighlight(qint64 start, qint64 end);
        void clearHighlight();
        void commentRange(qint64 start, qint64 end, const QString& comment);
        void uncommentRange(qint64 start, qint64 end);
        void clearComments();
        void setVerticalScrollBarValue(int value);
        void scroll(QWheelEvent *event);

};
