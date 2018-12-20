import pandas as pd

pd.set_option('display.expand_frame_repr', False)

def clean():
    path = r"C:\Users\Thijs\devGroup\PersonalProjects\Python\forex\History\Raw\GBPJPY_1_65000.csv"
    df = pd.read_csv(path, header=None, names=['Date', 'O', 'H', "L", "C", "V", "Up", "Low", "Base", "Rsi", "Signal", "e5", "e13", "e50", "e200", "e800"])
    df.drop(df.index[:800], inplace=True)
    df['Date'] = pd.to_datetime(df['Date'], format='%Y.%m.%d %H:%M:%S')
    df.set_index('Date', inplace=True)
    path = r"C:\Users\Thijs\devGroup\PersonalProjects\Python\forex\History\Cleaned\GBPJPY_1_65000.csv"
    df.to_csv(path)
    print("clean()")

def logic():
    path = r"C:\Users\Thijs\devGroup\PersonalProjects\Python\forex\History\Cleaned\GBPJPY_1_64999.csv"
    df = pd.read_csv(path, index_col=0)
    df.drop(["O", "C", "H", "L", "V", "Base", "Signal", "e5", "e13", "e50", "e200", "e800"], axis=1, inplace=True)
    RsiUp = df.loc[df["Rsi"] >= df["Up"]]
    RsiLow = df.loc[df["Rsi"] <= df["Low"]]
    path = r"C:\Users\Thijs\devGroup\PersonalProjects\Python\forex\History\Filtered\GBPJPY_1_RsiUp.csv"
    RsiUp.to_csv(path, sep=';')
    path = r"C:\Users\Thijs\devGroup\PersonalProjects\Python\forex\History\Filtered\GBPJPY_1_RsiLow.csv"
    RsiLow.to_csv(path, sep=';')
    print("logic()")

def labelReader():
    path1 = r"C:\Users\Thijs\devGroup\PersonalProjects\Python\forex\History\Labeled\Label_GBPJPY_15.csv"
    path2 = r"C:\Users\Thijs\devGroup\PersonalProjects\Python\forex\History\Cleaned\GBPJPY_15_15462.csv"
    path3 = r"C:\Users\Thijs\devGroup\PersonalProjects\Python\forex\History\joined\GBPJPY.csv"
    label = pd.read_csv(path1, index_col=0, sep=";")
    df = pd.read_csv(path2, index_col=0)
    joined = pd.merge(df, label, on='Date')
    joined.to_csv(path3)
    print("labelReader()")

def volume():
    path = r"C:\Users\Thijs\devGroup\PersonalProjects\Python\forex\History\Cleaned\GBPJPY_1_65000.csv"
    df = pd.read_csv(path, parse_dates=[0], index_col=0, infer_datetime_format=True)
    date = '2018-11-22'
    ts = df.between_time('00:00', '08:00')
    ts = ts.loc[date:date]
    high = ts["V"].loc[ts['O'] < ts['C']]
    low = ts["V"].loc[ts['O'] > ts['C']]
    numH = high.sum()
    numL = low.sum()
    print(numH, numL)


def expl():
    str = '2018.05.02 21:15:00'
    new = pd.to_datetime(str, format='%Y.%m.%d %H:%M:%S')
    print(str)
    print(new)


volume()