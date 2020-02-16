/// @description Perform motion and fades

lx_pos_size += Time.deltaTime * lx_pos_growSpeed;
lx_neg_size += Time.deltaTime * lx_neg_growSpeed;
ly_pos_size += Time.deltaTime * ly_pos_growSpeed;
ly_neg_size += Time.deltaTime * ly_neg_growSpeed;

lx_pos_growSpeed = max(0.0, lx_pos_growSpeed - Time.deltaTime * lx_pos_growSlow);
lx_neg_growSpeed = max(0.0, lx_neg_growSpeed - Time.deltaTime * lx_neg_growSlow);
ly_pos_growSpeed = max(0.0, ly_pos_growSpeed - Time.deltaTime * ly_pos_growSlow);
ly_neg_growSpeed = max(0.0, ly_neg_growSpeed - Time.deltaTime * ly_neg_growSlow);

fadeLife += Time.deltaTime;
if (fadeLife > fadePoint)
	image_alpha -= fadeSpeed * Time.deltaTime;
	
if (image_alpha < 0.0)
	delete(this);