import pyodbc
import datetime
from pathlib import Path
import openpyxl

fileNameOrder = 'OrderList.xlsx'  # tên file (.xlsx) lưu thông đơn đặt hàng
pathW = ''  # đường dẫn đến file (.xlsx) lưu thông đơn đặt hàng

driver = 'ODBC Driver 17 for SQL Server'
server = 'KATOIT'
database = 'OnlineShop'
cursor = None

'''
Select: SELECT * FROM TestDB.dbo.Person
Insert: INSERT INTO TestDB.dbo.Person (Name, Age, City)
                VALUES
                ('Bob',55,'Montreal'),
Update: UPDATE TestDB.dbo.Person
                SET Age = 29,City = 'Montreal'
                WHERE Name = 'Jon'
Delete: DELETE FROM TestDB.dbo.Person 
                WHERE [Name] in ('Bill','Mia')
# tableName: Product, Receipt, Detail_Receipt, User_Manual, Customer
'''


def get_db(sql_select):
    global cursor
    try:
        conn = pyodbc.connect('Driver={' + driver + '};'
                                                    'Server={' + server + '};'
                                                                          'Database={' + database + '};'
                                                                                                    'Trusted_Connection=yes;')
        cursor = conn.cursor()
        cursor.execute(sql_select)
    except Exception as e:
        print('Error Select database: {}'.format(e.args))
    finally:
        list_all = []
        for i in cursor:
            list_all.append(i)
        return list_all


def set_db(sql_insert):
    try:
        conn = pyodbc.connect('Driver={};'
                              'Server={};'
                              'Database={};'
                              'Trusted_Connection=yes;'.format(driver, server, database))
        cursor = conn.cursor()
        cursor.execute('''{}'''.format(sql_insert))
        conn.commit()
    except Exception as e:
        print('Error Insert database: {}'.format(e.args))
        print(sql_insert)
        return False
    finally:
        return True


def insert_order(data_insert):
    """ # listALL = ['id_customer', '0987191143', 'Nguyen Van An', 'address', 'total', 'amount', id_product] # """
    id_customer = data_insert[0]
    phone = data_insert[1]
    name = data_insert[2]
    print(name)
    address = data_insert[3]
    total = data_insert[4]
    amount = data_insert[5]
    id_product = data_insert[6]
    date = datetime.datetime.today().date()
    if phone[0] in '+84':
        phone = '0' + phone.lstrip('+84')
    sql_insert_receipt = '''INSERT INTO {}.dbo.Receipt (id_customer, address, date, total) 
        VALUES ({},N'{}',{},{})'''.format(database, id_customer, address, date, total)

    if id_customer is None:
        sql_insert_customer = '''INSERT INTO {}.dbo.Customer (name, phoneNumber) 
                                    VALUES (N'{}','{}')'''.format(database, name, phone)
        if set_db(sql_insert_customer):
            sql_select_customer = 'SELECT * FROM {}.dbo.Customer ORDER BY id DESC'.format(database)
            id_customer = get_db(sql_select_customer)[0][0]
            sql_insert_receipt = '''INSERT INTO {}.dbo.Receipt (id_customer, address, date, total) 
                VALUES ({},N'{}','{}',{})'''.format(database, id_customer, address, date, total)
    if set_db(sql_insert_receipt):
        sql_select_receipt = 'SELECT * FROM {}.dbo.Receipt ORDER BY id DESC'.format(database)
        id_receipt = get_db(sql_select_receipt)[0][0]
        sql_insert_detail_receipt = '''INSERT INTO {}.dbo.Detail_Receipt (id_receipt, id_product, amount) 
            VALUES ({},{},{})'''.format(database, id_receipt, id_product, amount)
        if set_db(sql_insert_detail_receipt):
            return True
    return False


def select_product():
    sqlSelect = 'SELECT * FROM ' + database + '.dbo.Product JOIN ' + database + '.dbo.User_Manual ON User_Manual.id_product = Product.id'
    infoProduct = get_db(sqlSelect)
    return infoProduct


def select_old_customers(phone_number):
    sql_select = 'SELECT Customer.id,name,address FROM ' + database + ".dbo.Customer JOIN " + database + ".dbo.Receipt ON Receipt.id_customer = Customer.id WHERE phoneNumber = " + str(
        phone_number)
    global cursor
    infoCustomer = []
    try:
        conn = pyodbc.connect('Driver={};'
                              'Server={};'
                              'Database={};'
                              'Trusted_Connection=yes;'.format(driver, server, database))
        cursor = conn.cursor()
        cursor.execute(sql_select)
        row = cursor.fetchone()
        if row:
            infoCustomer.append(row[1])
            address = str(row[2]).split(', ')
            infoCustomer.append(address[2])
            infoCustomer.append(address[1])
            infoCustomer.append(address[0])
            infoCustomer.append(row[0])
            print('Old Customer: {}'.format(phone_number), infoCustomer)
            return infoCustomer
    except Exception as e:
        print('Error Select database: {}'.format(e.args))
        print(sql_select)
        print('Old Customer: None')
        return None


def save_order(order_customer_name, order_phone_number,
               ordered_product_name,
               amount_order, total_order_amount,
               order_address):
    try:
        fileNameFullPath = Path(pathW, fileNameOrder)
        wb_obj = openpyxl.load_workbook(fileNameFullPath)
        sheet = wb_obj.active
        # Thêm 1 hàng giá trị vào file
        order_date = datetime.datetime.today()
        sheet.append(
            [order_customer_name, order_phone_number,
             ordered_product_name,
             amount_order, total_order_amount, order_date,
             order_address])
        # Lưu file
        wb_obj.save(fileNameFullPath)
        print('# --------- Order saved successfully! ---------')
    except Exception as e:
        print('# --------- Order saved failed! ---------')
        print('!!!Error: ', type(e), e)
        print(e.args)
        return False
    finally:
        return True

# if __name__ == '__main__':
#     phone_number = '0987191143'
#     a = select_old_customers(phone_number)
#     print(a)
#     listALL = [1, '0987191143', 'Nguyen Van An', 'Yên Mạc, Yên Mô, Ninh Bình', 320000, 10, 1]
#     listALL2 = [None, '0987191145', 'Lê Quang Thọ', 'Yên Thái, Yên Mô, Ninh Bình', 320000, 10, 1]
#     insert_order(listALL2)
    # if phone_number[0] in '+84':
    #     phone_number = '0' + phone_number.lstrip('+84')
    # print(phone_number)
