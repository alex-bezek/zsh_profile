<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInita020761f4b7f720ef61acfa80b416dcd
{
    public static $files = array (
        '73093016f0f057ca20b130e3f3a1ed3a' => __DIR__ . '/../..' . '/config/routes.php',
    );

    public static $prefixLengthsPsr4 = array (
        'F' => 
        array (
            'Frlnc\\Slack\\' => 12,
        ),
        'A' => 
        array (
            'AlfredSlack\\Models\\' => 19,
            'AlfredSlack\\Libs\\' => 17,
            'AlfredSlack\\Helpers\\Service\\' => 28,
            'AlfredSlack\\Helpers\\Http\\' => 25,
            'AlfredSlack\\Helpers\\Core\\' => 25,
            'AlfredSlack\\Helpers\\' => 20,
            'AlfredSlack\\Controllers\\' => 24,
            'AlfredSlack\\Config\\' => 19,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'Frlnc\\Slack\\' => 
        array (
            0 => __DIR__ . '/..' . '/frlnc/php-slack/src',
        ),
        'AlfredSlack\\Models\\' => 
        array (
            0 => __DIR__ . '/../..' . '/models',
        ),
        'AlfredSlack\\Libs\\' => 
        array (
            0 => __DIR__ . '/../..' . '/libs',
        ),
        'AlfredSlack\\Helpers\\Service\\' => 
        array (
            0 => __DIR__ . '/../..' . '/helpers/service',
        ),
        'AlfredSlack\\Helpers\\Http\\' => 
        array (
            0 => __DIR__ . '/../..' . '/helpers/http',
        ),
        'AlfredSlack\\Helpers\\Core\\' => 
        array (
            0 => __DIR__ . '/../..' . '/helpers/core',
        ),
        'AlfredSlack\\Helpers\\' => 
        array (
            0 => __DIR__ . '/../..' . '/helpers',
        ),
        'AlfredSlack\\Controllers\\' => 
        array (
            0 => __DIR__ . '/../..' . '/controllers',
        ),
        'AlfredSlack\\Config\\' => 
        array (
            0 => __DIR__ . '/../..' . '/config',
        ),
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInita020761f4b7f720ef61acfa80b416dcd::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInita020761f4b7f720ef61acfa80b416dcd::$prefixDirsPsr4;

        }, null, ClassLoader::class);
    }
}
