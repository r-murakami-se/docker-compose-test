<?php
namespace App\Shell;

use Cake\Console\Shell;
use Cake\Mailer\Email;

class MailTestShell extends Shell
{
    public function main()
    {
        $this->out("📨 メール送信テストを開始します...");

        $email = new Email('default'); // config/app.phpの 'Email.default' を使用

        try {
            $result = $email->setTo('murakami@se-sendai.co.jp')
                ->setSubject('テストメール - ' . date('Y-m-d H:i:s'))
                ->send('これはCakePHPからのテストメールです。');

            $this->out("✅ メール送信成功！");
            $this->out(print_r($result, true));
        } catch (\Exception $e) {
            $this->err("❌ メール送信失敗: " . $e->getMessage());
        }
    }
}
