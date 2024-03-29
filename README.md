To configure the DB need to change Car_Item and DBManager.service inside services/DBManager:
    Two option:
        1)
            - CarItem = Car_Realm
            - DBManager.service = RealmManager.shared
        2)
            - CarItem = Car_CoreData
            - DBManager.service = CoreDataManager.shared
