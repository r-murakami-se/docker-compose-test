<?php
namespace App\Shell;

use Cake\Console\Shell;

class TestShell extends Shell {

	public function main() {
        $this->out("---------テストシェルスタート---------");
    }
}
