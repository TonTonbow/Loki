import UserDefaultsCore

public protocol DefaultSaunaTimeRepository {
    func defaultSaunaTimes() throws -> DefaultSaunaTimes
    func saveDefaultSaunaTimes(_ defaultSaunaTimes: DefaultSaunaTimes) throws
}

public final class DefaultSaunaTimeUserDefaultsClient {
    public static let shared = DefaultSaunaTimeUserDefaultsClient()

    private let localDataSource: any LocalDataSource

    private init(localDataSource: some LocalDataSource = UserDefaultsDataSource.shared) {
        self.localDataSource = localDataSource
    }
}

extension DefaultSaunaTimeUserDefaultsClient: DefaultSaunaTimeRepository {
    public func defaultSaunaTimes() throws -> DefaultSaunaTimes {
        do {
            return try localDataSource.object(forKey: .defaultSaunaTimes)
        } catch UserDefaultsError.missingValue {
            return .init()
        } catch {
            throw error
        }
    }

    public func saveDefaultSaunaTimes(_ defaultSaunaTimes: DefaultSaunaTimes) throws {
        try localDataSource.set(defaultSaunaTimes, forKey: .defaultSaunaTimes)
    }
}
