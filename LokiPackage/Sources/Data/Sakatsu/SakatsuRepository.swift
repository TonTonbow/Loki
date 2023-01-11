import UserDefaultsCore

public protocol SakatsuRepository {
    func sakatsus() throws -> [Sakatsu]
    func saveSakatsus(_ sakatsus: [Sakatsu]) throws
    func makeDefaultSaunaSet() -> SaunaSet
}

public struct SakatsuUserDefaultsClient {
    public static let shared: Self = .init()
    private static let sakatsusKey = "sakatsus"

    private let userDefaultsClient = UserDefaultsClient.shared

    private let settingsRepository: any DefaultSaunaTimeRepository

    private init(settingsRepository: some DefaultSaunaTimeRepository = DefaultSaunaTimeUserDefaultsClient.shared) {
        self.settingsRepository = settingsRepository
    }
}

extension SakatsuUserDefaultsClient: SakatsuRepository {
    public func sakatsus() throws -> [Sakatsu] {
        do {
            return try userDefaultsClient.object(forKey: Self.sakatsusKey)
        } catch UserDefaultsError.missingValue {
            return []
        } catch {
            throw error
        }
    }

    public func saveSakatsus(_ sakatsus: [Sakatsu]) throws {
        try userDefaultsClient.set(sakatsus, forKey: Self.sakatsusKey)
    }

    public func makeDefaultSaunaSet() -> SaunaSet {
        do {
            let defaultSaunaTimes = try settingsRepository.defaultSaunaTimes()
            var defaultSaunaSet = SaunaSet()
            defaultSaunaSet.sauna.time = defaultSaunaTimes.saunaTime
            defaultSaunaSet.coolBath.time = defaultSaunaTimes.coolBathTime
            defaultSaunaSet.relaxation.time = defaultSaunaTimes.relaxationTime
            return defaultSaunaSet
        } catch {
            return .init()
        }
    }
}
