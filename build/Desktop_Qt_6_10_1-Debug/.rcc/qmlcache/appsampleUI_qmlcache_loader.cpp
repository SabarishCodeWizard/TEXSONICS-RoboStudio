#include <QtQml/qqmlprivate.h>
#include <QtCore/qdir.h>
#include <QtCore/qurl.h>
#include <QtCore/qhash.h>
#include <QtCore/qstring.h>

namespace QmlCacheGeneratedCode {
namespace _qt_qml_sampleUI_Main_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_sampleUI_LeftPanel_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_sampleUI_RightPanel_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_sampleUI_PanelCard_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_sampleUI_StatusButton_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_sampleUI_ActionButton_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_sampleUI_AxisControl_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_sampleUI_ValueBox_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_sampleUI_MiniInput_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_sampleUI_CameraController_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_sampleUI_GridEnvironment_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_sampleUI_RobotArm_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}

}
namespace {
struct Registry {
    Registry();
    ~Registry();
    QHash<QString, const QQmlPrivate::CachedQmlUnit*> resourcePathToCachedUnit;
    static const QQmlPrivate::CachedQmlUnit *lookupCachedUnit(const QUrl &url);
};

Q_GLOBAL_STATIC(Registry, unitRegistry)


Registry::Registry() {
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/sampleUI/Main.qml"), &QmlCacheGeneratedCode::_qt_qml_sampleUI_Main_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/sampleUI/LeftPanel.qml"), &QmlCacheGeneratedCode::_qt_qml_sampleUI_LeftPanel_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/sampleUI/RightPanel.qml"), &QmlCacheGeneratedCode::_qt_qml_sampleUI_RightPanel_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/sampleUI/PanelCard.qml"), &QmlCacheGeneratedCode::_qt_qml_sampleUI_PanelCard_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/sampleUI/StatusButton.qml"), &QmlCacheGeneratedCode::_qt_qml_sampleUI_StatusButton_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/sampleUI/ActionButton.qml"), &QmlCacheGeneratedCode::_qt_qml_sampleUI_ActionButton_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/sampleUI/AxisControl.qml"), &QmlCacheGeneratedCode::_qt_qml_sampleUI_AxisControl_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/sampleUI/ValueBox.qml"), &QmlCacheGeneratedCode::_qt_qml_sampleUI_ValueBox_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/sampleUI/MiniInput.qml"), &QmlCacheGeneratedCode::_qt_qml_sampleUI_MiniInput_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/sampleUI/CameraController.qml"), &QmlCacheGeneratedCode::_qt_qml_sampleUI_CameraController_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/sampleUI/GridEnvironment.qml"), &QmlCacheGeneratedCode::_qt_qml_sampleUI_GridEnvironment_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/sampleUI/RobotArm.qml"), &QmlCacheGeneratedCode::_qt_qml_sampleUI_RobotArm_qml::unit);
    QQmlPrivate::RegisterQmlUnitCacheHook registration;
    registration.structVersion = 0;
    registration.lookupCachedQmlUnit = &lookupCachedUnit;
    QQmlPrivate::qmlregister(QQmlPrivate::QmlUnitCacheHookRegistration, &registration);
}

Registry::~Registry() {
    QQmlPrivate::qmlunregister(QQmlPrivate::QmlUnitCacheHookRegistration, quintptr(&lookupCachedUnit));
}

const QQmlPrivate::CachedQmlUnit *Registry::lookupCachedUnit(const QUrl &url) {
    if (url.scheme() != QLatin1String("qrc"))
        return nullptr;
    QString resourcePath = QDir::cleanPath(url.path());
    if (resourcePath.isEmpty())
        return nullptr;
    if (!resourcePath.startsWith(QLatin1Char('/')))
        resourcePath.prepend(QLatin1Char('/'));
    return unitRegistry()->resourcePathToCachedUnit.value(resourcePath, nullptr);
}
}
int QT_MANGLE_NAMESPACE(qInitResources_qmlcache_appsampleUI)() {
    ::unitRegistry();
    return 1;
}
Q_CONSTRUCTOR_FUNCTION(QT_MANGLE_NAMESPACE(qInitResources_qmlcache_appsampleUI))
int QT_MANGLE_NAMESPACE(qCleanupResources_qmlcache_appsampleUI)() {
    return 1;
}
